Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7667C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjKj-0007f8-Ed; Thu, 30 May 2024 13:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjKh-0007ej-OF
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:12:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sCjKf-0004S2-TT
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:12:55 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44UFOGsX001930; Thu, 30 May 2024 17:12:48 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DLk5mBlvQQDFemAajjuafqg4dLgS86bZN57ctHj48gYY=3D;_b?=
 =?UTF-8?Q?=3DG7PIcgrustDNA/Cw0johaDxkhPRmInsicIveH4+fzHlOwXrkhUY5GEtFEnF2?=
 =?UTF-8?Q?6l+2iKOl_GPD8HCnLG0b6HpW7p3zOH2KJM8t5ClERdgPAA0cFu8zn4mY5NSClc6?=
 =?UTF-8?Q?xYKhaSfTelNZn4_NQUi7tsBixmROHrF60vRSk3IZJMLjxOnFkFnJeWDVkng+OX1?=
 =?UTF-8?Q?ydrAu43Tfp3ihPe7dgbi_UK5YfjDJ3OffaYbFT5CAxwL0UN/PIV8r21vN7OuBTo?=
 =?UTF-8?Q?z+Wgww9eKolvyY1efIpv0CTAYJ_6dVPeYxLH+g1AnW2vBvK4Rc2o5pvJ98IKwqj?=
 =?UTF-8?Q?Q1S4Jk5whq1gGOvS3mTEj2ZIy3kVU6Ro_Eg=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fchj5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:12:47 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44UGV9c3014967; Thu, 30 May 2024 17:12:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc538dmja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 May 2024 17:12:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX9qkQyu2TZ1VLZtDzjitZvSnpMgbFV3IOH4PrLSMSKEH15ODDeqMab1DuBBb0BNQjwL+X0WgRYQ9KwE+PcWYboEVirVr3xVKnO0QcOIzoa6AAe1ZYUUVAaLdRDKRPPNn5Dg6ktkBcEjhdLqKnwcdQ5xrNoOI7d4ABMb42d3xlm/o09EVx9c2s1NRywJwIJ4OhN91zHj6w3MKIdEY6m5r4kRO1V0woSHguaKH5TFwAEW1LnFLRO/mug+zPMH1XzgWuvtEF7ExK+RbNhOk1/FMAj+Qh2dksoHn8sXb2j5kLl90vNmKAskPmmveFeUSEflAEy4rRgw2Yv7Q/FONtbIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk5mBlvQQDFemAajjuafqg4dLgS86bZN57ctHj48gYY=;
 b=Vj3//w2OGQU8sO1hazV4+VP5BYAhB8RUh/iy03UOmwWi0dqlukvFBbIbqw811Bfm4UkeoEUvQ/ea44teAEFlF+3ghjw37uLdLUtZv7kMdkJyulGIrIrTAgUX6h3TH23nv9b7JaqBaUbOYPNb+yY69EL4qY6sSiEKkXAnc+jK1IihdONjvZYz2dQiTqV2CQR/ceHn2twBPLWFclywZAeJf6T+ZeUV+bvMjTH9jvKPFOVKPrd3aWPz+k3uoXiXK+RrTbch5C/GOvlai0J11wLpKLcb3mzogW4Gt+3R83h3BAOl5xmdIBpvn6aRbD8yB7xS+xLGle0iUYdyQ8+qNYqffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk5mBlvQQDFemAajjuafqg4dLgS86bZN57ctHj48gYY=;
 b=A6eq/tJg1KjJWf0Uvf8a0DJsemnnT2Tz8Yqie6OEPsENgp984++qT4zGnl46dkkBMd2IAeu2srzYGo7jSiaEby4+pR/bFS4WZTt21NBebmeviaXYDxdkhiwcpiNox7B63ykceyIowLGCHrBfGX8LV0i7FpAK9KJHBkSg87JeIMI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH0PR10MB5195.namprd10.prod.outlook.com (2603:10b6:610:c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:12:44 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:12:44 +0000
Message-ID: <e0cb49da-9799-4a26-8844-f5055b6ae45b@oracle.com>
Date: Thu, 30 May 2024 13:12:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 19/26] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-20-git-send-email-steven.sistare@oracle.com>
 <ZlZQVijf2weEmzYK@x1n> <c3f23e83-81d7-469a-aa04-29785fa6f8d7@oracle.com>
 <ZleBOx6pN6KCn0a2@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZleBOx6pN6KCn0a2@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0066.namprd19.prod.outlook.com
 (2603:10b6:208:19b::43) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH0PR10MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2109492e-05af-442c-90d4-08dc80cbb8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1UyM3lyeC81WGtQN3N2c2d0U25Nck9iSTVKUlJsNnBpNzZKcERELzhhUms2?=
 =?utf-8?B?a1ROZVdIdm85YW8rMlJYQ0ZBUitSWm5saTRIMHNNMWR1elA4bzRSN1FFT0Yw?=
 =?utf-8?B?QS9kTmFUTjMrS1dmTW4wSFExd3BsbEYraUpFeW4rVUl6eGgyV282WFZhRDFU?=
 =?utf-8?B?bEJwT2tTTVFLcmw4N0FtRXhFU2VtMU1Fd29QR0hkZ0ZmRUVYV0VIM0E2ZFl4?=
 =?utf-8?B?dnZLNE9nU2JCR3M2WXh6YzFNTnJlcVdEbnFWbGNyUHZKYlhrZWZzaXg5Z2xW?=
 =?utf-8?B?OGNFMVFIMmh2STNGVEpnRWkxbnVWRWFsYTZDQjBTenlBRG5PdEZuYWdVaTN5?=
 =?utf-8?B?dmVnWld1MUFjVFg4dXVrcTF4K01sZVdUUlZ0TEFiUStVVHRQU2xLcHN1NGNP?=
 =?utf-8?B?OHRlUVlNbTNiSFFkejdENFpZSHJ5Q3ArOXpQd0xtbTlJTElZS05uQlVvamdU?=
 =?utf-8?B?YnVsVlBrOHNTU0dKMXVEOG4xaWcrMy9QdWFDcFZqYVBma01taXdkMXloRU8x?=
 =?utf-8?B?d0cxZGlFeW1hQkpSb3BuekZQcDU5K1BmZ09rcWRkUSt1SWVtakttRGNQOUpa?=
 =?utf-8?B?RmdKQVQ2N1hiaU96QW1kL2pzZHNEaWpxbWFXUkI0R2RXKzMxU1NmTm9vMEV5?=
 =?utf-8?B?RFpMcG9NaU1MNXArNkgxNlB5ZytFckxXWFVoUTluTDcySnJrdXRCcFBRSkxq?=
 =?utf-8?B?cmhYUEt5c2lXNnd4NmJSay90S1N3dlAzL09tOXlCRlRteVpOS2pFQXNxOWFp?=
 =?utf-8?B?b3JIOURFdjhYbWNueEVpVWkzZ0VLN21YSUQ0aFBCaTdidW9PK2hPMXpGbUdP?=
 =?utf-8?B?UGR6NFNQdC9qNXZsTUtVQzhxUEE0N3hYYm9SaHFVMmp4UStPdTM4a3g3Y3A2?=
 =?utf-8?B?cWtmKzNUSU96aFJobVVYd1JQeldhTzFqTkU4alFJWlJ6Mng2QXdzM3VMSnZ4?=
 =?utf-8?B?N0hXK2JxNmFLK0tvUHZWRGZSQ0JnUWpOY2x5ajAvRUY1OTg5VUhhZjVKZlBp?=
 =?utf-8?B?eDZ6bUp6OUJ3TVVXb1JOdGdJOExCMzhIUldJelYxWFhDMVpncnhiRzlweEsy?=
 =?utf-8?B?WHpNVmxIUFhqYitJby83aVBlK1FpZEFsamxJUzhsNWF2WWh2V1NrRkNES04z?=
 =?utf-8?B?OGQ2RVBleVp3c1MrNk1BdXNRMHNRYXFkWjRtdUF4OHR2aHRyWElUYVlLbVU5?=
 =?utf-8?B?K0hkTkFpV3ZYWjZKMnhBVFFTMjBwblMwY25CcEFQcldHckVvMjVadXVxM3Y1?=
 =?utf-8?B?Qm92R3ZzcEVja25pOVJoRFNrN1YwYWhmU1lUYmRYVVJyM21DR3VxS2xrS1hm?=
 =?utf-8?B?cHBUaFRsNDcxU3ZrbzJ1Wkh0bG1UcnNpS1lUOE44MXdZbll1dFIyeENkMUpF?=
 =?utf-8?B?a1hDZ0g0TnZwL0xpSVFMazJkek5RNnhiQmRQNG9WeVNLeXVzME9WRS9XMSt6?=
 =?utf-8?B?Wm5EWUxQaHZLVk1hOExmdEJuSERCTm1NZmFkQlZCUzJVUFRJS0pSR2pYaEcr?=
 =?utf-8?B?V2JQa3V4OTdGL0RSWEFNTUFEQTZhVDh1bmlkcnA2aGFHRGVRdUJyUnYxWXdr?=
 =?utf-8?B?MEhRdW40Vm1YQ1lrd3M1V3duazJJd3NlVzFLSWYvYXNTckQ4WW1mRElmMEdh?=
 =?utf-8?B?Y3ZWZWZOMmd3YjFoZysyVGpBeUVCajZSbDk2ZDN1dldxWTM4ODdWTm0xNmNT?=
 =?utf-8?B?Z01lUmhobU9XOUNxL3dSMWdvT29OYXRjNjRhU3VWYzJkWFQ3MkN0akJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDdLSGhUK29ldFdzYnRBdE1IL2cwbFdmTHRwYk54RG8zV1pmL2thcmxtSVhh?=
 =?utf-8?B?UHhTTTNWajVEcTFLR1RncVZSYkpsaks4a2plMU5TaU54V2tobjRUK0x0ZFNO?=
 =?utf-8?B?bEhjWGRLaWZZMmRPR3h5YWJWOHMvOXA2ck9jSTIvZmlqazA3eXc0anAzQmpM?=
 =?utf-8?B?c09wVVEzWDRnb1ZQUmUyQWJsK25wSUxoNjNMd0FvZDhpNnNnaE82UElodi96?=
 =?utf-8?B?MnRHM21qalFJM0RQemNFdUpOKzRXY1RpQUR6bER3c0ROS3BvR0Mza2JYWGQ5?=
 =?utf-8?B?WHZxak9kRmZzOTNUUjhsNlM4VU83M3JyKzl5R1p2VDh1OWdicDZzUGlzV1h4?=
 =?utf-8?B?dmVHSXJtUjYxTFJDRGV1SG1Ma1F5Und4Umd4ZzRPN3dad3B6cVB1dnlyclZY?=
 =?utf-8?B?dExkZzZGRjRWK0VNVTZzMCtqTUQvckw5OGIrZUx6aTFzejhXMUtNNnMyMHFL?=
 =?utf-8?B?ald2REhlNEg2UFFOQ1cwSWoveXNHKzk3aGE2TlB2Tml6VjJBYU5DeUFTYm9M?=
 =?utf-8?B?WnB3RTM2VitkbDEvNkJ0RUtUZXkrN05CbEZIZlBnMnM3RUVJVWE2ZmlUUGV0?=
 =?utf-8?B?OFNQcW4xU0dXdDlVRzRyN2swNkQ4RS9MSUpTM0pBSkhtcjdkZm5EdU5SNXRm?=
 =?utf-8?B?c3FjZExoNnR2OTc2WEM5NTNoVTQ2YnR0YTRIbCtydGFWR0pXKytuYVpkdU1P?=
 =?utf-8?B?MDFKTVppbXUrYTdJUWlhR1hCTXB0dUVucGEwNmh0alZYdkxmNnRhNFgrU0hI?=
 =?utf-8?B?REM4WUt2MEhVWEpvTjhBWXU5TmkzamVTVDJSZ3Mwbm1UbTVDdkR1dUd5dFUy?=
 =?utf-8?B?ZENheHZKSWFqbFh1cWYxSWQ3ZXA2KzNxRFBGWFpuR2FEK1BFaG0wZ0o4L29m?=
 =?utf-8?B?MkhmeEhqRTJHTTVObUxIU0RVcGY0cGcvREtmNmE3M2dOMG9DRGUvdUlSQ1B3?=
 =?utf-8?B?YmlFbHNMVGpZSHBiQUozT1F1TFgrazRUcUxXMkFlakJOZEdFQmNwVTN5Wk1t?=
 =?utf-8?B?MHZ5eDJhb1BHT0t5dmNpNTNteFVyL3E0YjN3R0YvamY0clA5WkdJT0xKM2pS?=
 =?utf-8?B?UW1QeXJRZVNLUWF4S0tmTGFOVDJodEZ3TVZSS2tubGgwUmVmNHc0c3NDZ0k4?=
 =?utf-8?B?VHBOcVZBRU8vMTlteTU2YTJUckw1T3RtTURoUW1USlE0TUxLcTRpVWpDR2lH?=
 =?utf-8?B?bHdSY0kxVW1yRkF4d0JiN3l2OVpoUk1xT0xjVXlrbFB2M0xtVEhVS0tPNUph?=
 =?utf-8?B?YWFFUkJDTFJwZ2prSUdDdjRXLzV4bVJDaEpUNUpBY3BmNEhGSmZPYnBIU21D?=
 =?utf-8?B?S1FQY0FNVHJqcFZHcFhYbm5zT3dMY3UzQW9IZnlxYkJjUjFOTUFyVWhSVXNp?=
 =?utf-8?B?MU9uSnZHSnNuZGZKdERuZC9ZRUpoWTFMWDRyeGdnUDVhSThOeWFvOVFuU3Q5?=
 =?utf-8?B?Z2lBbmp5WDRtTE1LUHY4RXJOVXFyUXEyRDFSZnBZRHAvYms4TkRBQlp1MVpn?=
 =?utf-8?B?T1gyc0ZaM3Axci9QNkhMem91T1NGak5NUVFjT3NxL25XbXdsdnpaNXYyN09u?=
 =?utf-8?B?SGRPREkyYWExa2NCYXl4NWNmMTBvd1JQdC9kb0I1eVA3Ti9Fb0tPQWtrTVFG?=
 =?utf-8?B?NXFEaks0YjZTRWlZZWlyQUVqSXJwaFNkcUkwSXR0UDdSRmVQV1BKZjNqMXhH?=
 =?utf-8?B?NzB3NzR1bjZ4SlNSaEt0d3hZTFU3NTRMUThGSmphYS9DeFl5ai9yTXZyMmdl?=
 =?utf-8?B?aXQ5SnJrUVRQK3RrSkdYUmE2ZUxkc0ptZE9OL1I1emxBV2g1ZUE2bzJsb0Qy?=
 =?utf-8?B?aFBvYmxHK2tsMkszdnNTVTZENGpscEhzM3kramJTQjhoS24vbXZHc3RzYTRG?=
 =?utf-8?B?VTdKem5hZXAyNTNmOUVaai9IZUg1Q0VRSEhocWkyNnNxSVRmMG9EeDVyWjVZ?=
 =?utf-8?B?STAxVjlsbDMzd1dmTWlvbUVScGd6QXB6ZDhmUllvT3EvTytwS1hoV2xuZFVJ?=
 =?utf-8?B?WXJRbG93RVZ2bjFlV0V3bjRxaExVamU2Rng1djFNb0ZtKy8vZ29aUTFyM1VY?=
 =?utf-8?B?WWJJSkthTFRqcS9FTkJqRnJTTUNzdWhYNVlsdHRwbXVtV2Y2N0hSOVRIK2NS?=
 =?utf-8?B?eldtdWpack45ZHlUNnVNcGJUK0Zsc3JRL1ErazdWVHNXdmlLOVIrSGFYT3V3?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lAHXU3NWYiIdfnbD+M+d8T19IItYhmW04aRLMjEDlbLeZFzn3Cv6pZvNZt64V+7nxohEuOUUOhMhqJHOUynvCkRtCIBD9wDl35ZcKP5+QLGIZA2gbjTZDwc6uTyG6f8LdPv2SOadYBOL9A/foXftFRsDt27lhEW+V6iwgH0c/zI6Wr2CVd0XqNui9DWKVtF806jZijzzUp6bJmJi9o7Owv7h0XdJSNcryW4YvWjcqzigFcibH+hKeLfntr6Kh2cOLcBxoOuk75NrG6xUnS0E6mMQncP5aJTcGR7e3/ZQtA1hqnYEIPWYjZPrJM83AanQ5zdecSp5NJvYhQs8n8GBsrLTFTjY9YitflH3gtAOGNCUz+vWiFWDzPC0IPOLb7l3VyAE8bFTN13oFao3UthRDyv0jjh3y+d2+p9MUz+izfrRgW5433NNeh0xHHhfd5NWamWkCxooi+AZBgzGNB9aueN+2NdqDVeWk903l9pNwAgRh4XS2fZ/UcUAa+oVtUgDrpZHB/NrzrevIzdpMtogK8yTjGZPqB0MXWzgunv/Uy0j7UlXSxt6O5qlRkJ02qwgBdQDtwWLR8ugtE9DzGAiGUzMk5IAK7NxqtxVKoOBcVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2109492e-05af-442c-90d4-08dc80cbb8d1
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:12:44.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w3AwkTaZXjJJVDCezBsNR0BWGHfKXd8K40UPWcvrAPM6EkKr4eSPd2ev7xSNfpoqo16sZdsxNBBRb+CU9abbORHIksF0EhEJHKTIiivmmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300127
X-Proofpoint-GUID: huIotKWqCc0p3qNc84I0NhhHgpWzeGd6
X-Proofpoint-ORIG-GUID: huIotKWqCc0p3qNc84I0NhhHgpWzeGd6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/29/2024 3:25 PM, Peter Xu wrote:
> On Wed, May 29, 2024 at 01:31:53PM -0400, Steven Sistare wrote:
>> On 5/28/2024 5:44 PM, Peter Xu wrote:
>>> On Mon, Apr 29, 2024 at 08:55:28AM -0700, Steve Sistare wrote:
>>>> Preserve fields of RAMBlocks that allocate their host memory during CPR so
>>>> the RAM allocation can be recovered.
>>>
>>> This sentence itself did not explain much, IMHO.  QEMU can share memory
>>> using fd based memory already of all kinds, as long as the memory backend
>>> is path-based it can be shared by sharing the same paths to dst.
>>>
>>> This reads very confusing as a generic concept.  I mean, QEMU migration
>>> relies on so many things to work right.  We mostly asks the users to "use
>>> exactly the same cmdline for src/dst QEMU unless you know what you're
>>> doing", otherwise many things can break.  That should also include ramblock
>>> being matched between src/dst due to the same cmdlines provided on both
>>> sides.  It'll be confusing to mention this when we thought the ramblocks
>>> also rely on that fact.
>>>
>>> So IIUC this sentence should be dropped in the real patch, and I'll try to
>>> guess the real reason with below..
>>
>> The properties of the implicitly created ramblocks must be preserved.
>> The defaults can and do change between qemu releases, even when the command-line
>> parameters do not change for the explicit objects that cause these implicit
>> ramblocks to be created.
> 
> AFAIU, QEMU relies on ramblocks to be the same before this series.  Do you
> have an example?  Would that already cause issue when migrate?

Alignment has changed, and used_length vs max_length changed when
resizeable ramblocks were introduced.  I have dealt with these issues
while supporting cpr for our internal use, and the learned lesson is to
explicitly communicate the creation-time parameters to new qemu.

These are not an issue for migration because the ramblock is re-created
and the data copied into the new memory.

>>>> Mirror the mr->align field in the RAMBlock to simplify the vmstate.
>>>> Preserve the old host address, even though it is immediately discarded,
>>>> as it will be needed in the future for CPR with iommufd.  Preserve
>>>> guest_memfd, even though CPR does not yet support it, to maintain vmstate
>>>> compatibility when it becomes supported.
>>>
>>> .. It could be about the vfio vaddr update feature that you mentioned and
>>> only for iommufd (as IIUC vfio still relies on iova ranges, then it won't
>>> help here)?
>>>
>>> If so, IMHO we should have this patch (or any variance form) to be there
>>> for your upcoming vfio support.  Keeping this around like this will make
>>> the series harder to review.  Or is it needed even before VFIO?
>>
>> This patch is needed independently of vfio or iommufd.
>>
>> guest_memfd is independent of vfio or iommufd.  It is a recent addition
>> which I have not tried to support, but I added this placeholder field
>> to it can be supported in the future without adding a new field later
>> and maintaining backwards compatibility.
> 
> Is guest_memfd the only user so far, then?  If so, would it be possible we
> split it as a separate effort on top of the base cpr-exec support?

I don't understand the question.  I am indeed deferring support for guest_memfd
to a future time.  For now, I am adding a blocker, and reserving a field for
it in the preserved ramblock attributes, to avoid adding a subsection later.

- Steve

