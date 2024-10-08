Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA49CEFC29
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syCb6-00011C-Iu; Tue, 08 Oct 2024 11:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syCb0-0000zj-LF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:58:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syCay-0004vN-Ag
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:57:58 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtYru001782;
 Tue, 8 Oct 2024 15:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=g9DUQKHXXEVaCg+E+cAhempN3naLB+2/Ql1VFUnm9Kg=; b=
 ootfu+V81fdW3/5N6eGKbWjPGnlnjcooLuf0lxlmPZp/UWWXyfuDGzGO5td+Kq9G
 gGOBXd25Nd6DIksmuC4R25MTHZ6T59dRe9XE8G/1JoMdL/knTAjJe+Pqf63ed4P2
 U/5Dz10Z7oM7J1UxqClwJbRRnDuO3JdtwXfvFNNDpxRCatlkCX85guYvrwcJAMru
 gnB0o2X8z72TzhONhsS2cdj6KUPrqzVe2lDckI0fIqjCCUW7xHAWMF0puX7KpaR2
 k3t4yfV/bi6N5fiMLuspsgaKWy1DQXWRCuPnnAQY/jNUcG1mix6j9sJoK58WTql7
 Lnci4v6c0BCGQ/HZZMjCeQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dx8pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:57:50 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498FfSl1015371; Tue, 8 Oct 2024 15:57:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7cf22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awid+kfJmVEW8NCXXjw3AlGp6NEPsEs8CYCNqBIPEOMjiRa3Fvk0a+2eZet5GP4XtqGXfV+ShLmbID82a0tn1jsKbyIsqTeWn7jaAYnFyJGsFask94HCDfudkg/rsp0KzDl0vRqNYFmyqS/+4xX1tSIBs9J5WTyRN6lGBDhHX4sTYNpBuoVuDkYqm85A6X/iFDbCPIRtd/Et/bn5YrHtDZ+38pVQWKQo36YtErH9+UykO3pgpDxz9Da9IL0zD7L6eGIRnVqSi+Gub8DSHjoP8s4tIThEIypJqSKoKWvsMbiKDtcIGsHAla5ZvGNebd6LrkVHx46YgZ3r77cXT3w8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9DUQKHXXEVaCg+E+cAhempN3naLB+2/Ql1VFUnm9Kg=;
 b=DD3QPFZ9Hly0Rji0XMyTmayX6+FhJUtVF79+KQATJOIixEMRvSiMK51WDk3Tv2cKzamx48L2I31bTF49804/qslxgqipYbdFa+cATD7VaZwdvUlIl59wWLedwoju+fCa8l7pIft8eG1JG7zT1l5S7SiXGyzX8cB8FkSLegq7iNoLzDraIEwkzoSXA208Dlg/6Pwn+V0SwPy8JhFN2b+hIiRbnfHFE4/5wwNl2DuDKhOJ/HSFynEKCMiAE5GdSHIyBh0+M4feHnRTl3N1mlBxQAoNlDUdfjH5d5V7jAywmmdEFaoKD7nXkfkRDSLXAzEiguWF65L5NHpbpPMpFyB+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9DUQKHXXEVaCg+E+cAhempN3naLB+2/Ql1VFUnm9Kg=;
 b=vAlLxBDJ9kjL+uZ/MbOCLBEBc9CXEbvSpgs2ydlDJUvqAw2dET2lYpoWWcVYJuO0CcL97ChGbajm4ftNhlGSFGN3fzoJSiuE8B+JKJhmwTmfHFObCn55DPlw3QQs1RRUm2KJEAgI7NoZpQ2f/ttQQunTwDkk235TS2n6xavRjIE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 15:57:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:57:46 +0000
Message-ID: <bdaa662b-53fc-40f2-ab56-801d6413befd@oracle.com>
Date: Tue, 8 Oct 2024 11:57:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/13] migration: save cpr mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-4-git-send-email-steven.sistare@oracle.com>
 <ZwP7v5pZNsMuXPgW@x1n> <68f5b27f-a06c-44f6-ab4d-3d0a32195b70@oracle.com>
 <ZwRAHeS9bTipmUIv@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwRAHeS9bTipmUIv@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d42f878-244f-494c-f916-08dce7b1f38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm9OV0F5Y05KS2pHc2V6dXk4YXpxK2JFcnh6WXhyNUhHQnpTTnAxdDRFQjJJ?=
 =?utf-8?B?UUVROHlRMWtiWHFHaU5iTmZVOWFyZ3p1RWNtNlZmNHlzWUxqaFdDSVFUcERw?=
 =?utf-8?B?MEpCaWRlOFg2bDhBbzVheHFyRHU3WmlydGdIa1RSTTNWZnlieXBKNVQxRlli?=
 =?utf-8?B?bXVUUmJZUWY5cEgwRVZlblFIbnJnVEcrWEZ1SXM4cXBsb2xVanp0R2NpTGJ2?=
 =?utf-8?B?Y0IyajNrblJPcW5oMlV6SG5PZ1o0ckpxZ2Vsemc0QmtlNkY0bSs0clFXYnhG?=
 =?utf-8?B?a0ptaktYVnYrYStTUHBSRkQyOTNpZnozTUFkalVkQmxaOEVLNkZ3TmpUV2xr?=
 =?utf-8?B?UjFPK3JrQTc5TmY2Um4rSElMUkRTSHhqQUR5SjYrZWQvZ0tDKzlFZHdDVDRL?=
 =?utf-8?B?QUdwRXpWTWJSblBXdGFIOUtEbCs5YjRzVURsRytaV255bEJBV3BiUTFBWDRq?=
 =?utf-8?B?L2toa1lKU2dzb3crclU5SGwrSXhKMTZTYmNML3F6amcwTU9PVmVrNytqeEpa?=
 =?utf-8?B?S2h0VmhzOFJaS2U4TFZsaGpibm1EcU5ZY3dZNHhxNFpWYmRsTm9ITHpDK0FV?=
 =?utf-8?B?WndOcU8zdkVnTFU4NkNZeHR4a0RTTXc2b1VSVS85WnFxeG42UkpNbVVtVDRE?=
 =?utf-8?B?TG5ZZmlYY2dBQ3J2R2tteW1VNzh4RVZKTVltQXpjZktua1FWUkZnOXlmR2N4?=
 =?utf-8?B?Q0xaZ3N4T2w2QXJuZzhBT2NveU1rVlhiUnA1ZGtNRXFFMkpXS0hkNGdaYXQ1?=
 =?utf-8?B?dFJxbVJrT1ZjaU94RElKQ0lZK0hISEJGRlg5eW5ZWUVQNTVtZFdiTTVhenVz?=
 =?utf-8?B?NkFUUnR2STNLUGNDdDMzMkdUWGQySE91c3BiR0VBeE93eWxJUXl2ZUd4OFZD?=
 =?utf-8?B?QUI3OVp1M0cwN05aeTNWOS9XU1EwRXpCUFN5aWo4M0x3SWdlTDlLeE11RWZG?=
 =?utf-8?B?NHQzTTErQVBXcVpUSGptKzR1cFdCZEE1Qi82NXBnaVhVNVpuck9oS2haNjA1?=
 =?utf-8?B?dFFMV253TFF0ZVBCdHhqZEJOSXZhd3pnaUcvQ1BrMXpRdGdLTko0bjZ4bTdG?=
 =?utf-8?B?b2p3Q1hrZCsrbExIUGpFZ2M0TDNWYTl1c0ZaRTR5N2I4ZmJod3BsRHdHbmdh?=
 =?utf-8?B?QzBpQVNXd1pyQTk1aTlpN3oyZDJMR3VCNmgrZlJzVnpwajJ5dW5NeU9FM0NQ?=
 =?utf-8?B?Uk5JTndqNG92M2l5V3N4OU5qcDNOT1dCc0duK1RlMjQ4QVZMb0hvMFpwT0tw?=
 =?utf-8?B?YXhHZzhYWkFOQlR1TGZHUFNtZFF1TEJBYklIb1FTVHFjVGlqSmdKSlljMUk0?=
 =?utf-8?B?dEtRdWJVa21GdlpiQ2o5eHVCR1FzOG5lQk9kK0RLTzQ1MUczb21HMEhkOHRn?=
 =?utf-8?B?SGJwT2VlYVBObkVrKzdidHJnek5sYnlBZ3JHc0tCdU5IT3NZT2NrQy9mS0I4?=
 =?utf-8?B?ay9sNE9OdXcwS2RHK1FIcFUwZnJ6ZDl3cFV5TC9qbUE4N1hZeFRuU3JzUS96?=
 =?utf-8?B?ZWt5SnY1ekpiQlRZTEFrNkx3dktCenFqVUNEUlJka2MyVlR5V0JGei85aDJh?=
 =?utf-8?B?ekFrb0hEdCtZY2owNnFHck5xd00yZCtjTkJtMzdwK2tVU2FLSWZWejVTV1Bq?=
 =?utf-8?B?cGlLaHk3cStxd0hqcUg0VFBQN2VLMEU3RG43V1ZkTmtQN1IvTUIrUDIvZEsr?=
 =?utf-8?B?S1gwalJhdWtUOCsxanJFc3k2RzZoOXl5YXEwRC9wSWZhMXpPa2c1R0xnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdHaEpMTlBybExqN1JuSy85alZ3d1Q2dWFnNkQ3a1ZkUE4wMUFBYnorUG1I?=
 =?utf-8?B?cmR2NWJ2RTdRQ284K3JkRWhBbFNGaWVtOHMybTJXVVlnc01Wek90VURESFBq?=
 =?utf-8?B?d1lUWWZTOWg0VzA1UC8xcHZTclUrelNIOE9tOE5vaWtXbnZWM2U3bUZMajM5?=
 =?utf-8?B?bzNHV0hvc1owbXFicjZFRkVVRXh4NTFTa1BnaGFoc1JKVTM3bGJmNFNVSGlS?=
 =?utf-8?B?a2g4SmVmMWZvTThJWGI1cmRLSUEzU3VmTXArUmJHejVTNDB1M1lUREQ4Z1NE?=
 =?utf-8?B?TlhpMExJdHBMVEVTbDcvQ3pZbVppdDFpaHNsUGFFeVdaN2FJNlJhNnVBVzY5?=
 =?utf-8?B?YU5hZHd1VGt5cnI2VEFDV21HU1ovbzVUVW5iY0dZNWlXSWpQZWJqSkFDQWVx?=
 =?utf-8?B?SkVPQWdMNE1mU2c1WTJ0QUxxRi9iSm5oWVByRXdUelQxWkFjSm5CZHRHUnFh?=
 =?utf-8?B?aWEyMUN6SlEzVkdzcGloSTIwWnJ3WVFoSFlaVmMvT3dZOVRSYVNYTUVuNmVt?=
 =?utf-8?B?UFVmbEw3c2JITVZGb1hFbHNoMkNvS0x2TFF1RGs5TXMrRHkvRWRjaFNyM0lu?=
 =?utf-8?B?ZTVHUEpmMGVyaitpUW1mQ242OTdTdmZzbHpMZ1YzZ1pwWTZkMXdhdjRkdmp6?=
 =?utf-8?B?dERNb2dXbUR2SlVXSUxnWnB2WHZ3WS83eENHcXpkOHl1VllDZjlrWVVRTGxG?=
 =?utf-8?B?M0xBbTk1dEpUdk5DWC9TSmFFcnNFMTNpU0wrOW9EbWhzaHNGdEVuc3psbjZ5?=
 =?utf-8?B?cVFFcEhwNXI5U0ZTR3NqRXQxdmFFR0dXeDFwT20vTjMwWENESGpOcEVUWitm?=
 =?utf-8?B?NVlrWXFybGNkMk5ac2RjVGVSUWlBRUdiQmZYMmtlRlR0blg2ZmlpaStlMWsz?=
 =?utf-8?B?QmY5SDhwaWdpeHdyai9hYzNodENtK2NzYTJIOFdaOXJmUGNEOStaM0Q1aVlJ?=
 =?utf-8?B?Smc1aEdBVElJWElnYTA5Zzhnc0pzRXV2OEdhbExjb0NMczkxTzBpaG4vcFpE?=
 =?utf-8?B?RXJibURTTHFMdjN3SDlycmtLbFVNT29HYmIwMDRueHNOY1VxV0pNK1FsRG1V?=
 =?utf-8?B?dHpWR01yM0Rxd2NZS096UG5pTnhCaXR4TjduTWRWUWtSMlY5cE9UeGd4NjVn?=
 =?utf-8?B?MXMveGFpbUhqVVQ1MU1vYXozZ1lIWnN4aUtETjcxWkxDd0tCcG1VbGNJUmFM?=
 =?utf-8?B?eEtSYWpGTm5WY0ZyVTlCYXdyME9icTNkTzZ3elRkdVRBaUJOdUxWZUNwdE41?=
 =?utf-8?B?b2dLWXBwSnp1c1V2QkVkeE1HMW51OG9jM05WMTZ3M29UUFVZQ29FREcxRldW?=
 =?utf-8?B?cHh2WTRiYis4OFgzS1NpNFU3d3M2YmczNU9GSjNENTlrc1Q1UWIxZ2d4SHh3?=
 =?utf-8?B?NmR1M01ZZE9SU3FLaENGdy9POEQ0SFZ1NzA2cEJieE1Lc0dFNlc1TG9oeXZ1?=
 =?utf-8?B?RWpXTk9yWE9uVW1sU21rVVpITTlsMmJrdGtqZ1hpWjl4OFh4S3Eyd2ZwQmVK?=
 =?utf-8?B?bVU4RDYyMnFmRWNINnhJVUZqUEN6cU5TRmxqcDJLNytURUR2bzlyRVVxV2xC?=
 =?utf-8?B?UHpJam5tbm45ZkduSkJVTitkdURBMUhUUGdZQkxHOUxoMG52RWxKL1lUMm5I?=
 =?utf-8?B?Sm5za3pZenpKWGZBeHdaZWdCNWl0N1RLRDdmYzJ5WUtGRTdXTTlHc2QweERu?=
 =?utf-8?B?VUdxVml5L3o1U290N1FQQXpid1hTc25nSWhidzBVQzIySEJvTjJTOG5kS0tS?=
 =?utf-8?B?ZjBWblVHdC9uNnQ0djlYcVV2NDBHNDBpYjlZUlBUangwOVZvMnRqa2h4WnNs?=
 =?utf-8?B?M0hBTVJ6amdSUG8xYjJhclhWdytkVlh0RkZVRnBWU3J6a2tyOXFmeHNXNkZW?=
 =?utf-8?B?ci9vTlNJMGw2QUdjVHFtbFFKRmF1MjY2ck5pSEVRNXR5cUJwcVFEY09YU2xS?=
 =?utf-8?B?dkpvR2tLczJKajRsTkZyYzV0Qy9Pc2tQQ25FVU5wSVpScmtabEpLODhNNDha?=
 =?utf-8?B?cEJvWFhxYk84WDgwNXg4aXA5dDYrV2ZHNTdSQVo2d1NlTUJsRWVjdUNNWFpw?=
 =?utf-8?B?V3U3SkhNc0p6bWtUOHVLQXNBTUV4MGdsMWFWOXQvYkRIWE9wNkZkR3FibnN4?=
 =?utf-8?B?akJTVy9kWmVUcjJPemFKVWFhUFZFZ2s3eHdvK3YzeWJFNHRmUXFEUlBUNDhj?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FphWeGPfU0Elm6WjUDorDrWDPMi1X/lrZxNdlyeR6UqA6HO9GAxiO8KNyGRb/ilmNu06/DJhLkWZJEZIaCztjIlCu31yL60wEGbyCSosl0Y+JliBzhH3b6dFfXJgMnL2AnyZ0SOa/rEO/qsHCg9eyR2Kdf7N8VlF3q4rp115z9I/DmUpNrHlGg+VvhgbwCFi8WgZONcuE+SGJP7/8rD/RhTpaY+bvzELlAYKOmgdAayt11q8c37BBv+BavC6Hwd0rsNK9zWdNy8pJCOOAEEj5oo/sWNpCVbQSlvXFrOMFj7P/ijedawNrSEqdg5SsZmsGz8uAT5rqCAqCc93iKJuEJwcsd0WWoos6BkyX8EWDSBBOMYWK7SDT5uFiAEu9+PEYmEr8ZHcfwnYnxlmNFe/+fSlh5s4HGCORtmeuxk0YDFof3ggOBY2gneGFbQy1jbGRvM7HVAtkRHg46xGhywxcsOZ2MiewREnYG7il++jc3jikHJ5ABFyADIOxhl36LK+wScASgf1PlA6bX5b9QORqtjUFTKb7zseCVWXRAQy+rXrFuOPz0cMDAj8dpt4/v63nc3PG4TrN7nWQ8Zn7ROu9KJ9lIJTzjDsUYuriAYILfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d42f878-244f-494c-f916-08dce7b1f38b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:57:46.2832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwjTCXx0P3f577yRRlaS0svDPMTY5yInm5B3/LLSVTmIJiu98UE+X8W3Gfh4a9vO6hmhZhqVOtHJx8l5ZYkjlbeXzMkgiF2n1xf4kwucEoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_14,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080101
X-Proofpoint-GUID: gtSUK-PVItxOwpC6GWgxZn8sJANQYOVu
X-Proofpoint-ORIG-GUID: gtSUK-PVItxOwpC6GWgxZn8sJANQYOVu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/7/2024 4:10 PM, Peter Xu wrote:
> On Mon, Oct 07, 2024 at 03:31:09PM -0400, Steven Sistare wrote:
>> On 10/7/2024 11:18 AM, Peter Xu wrote:
>>> On Mon, Sep 30, 2024 at 12:40:34PM -0700, Steve Sistare wrote:
>>>> Save the mode in CPR state, so the user does not need to explicitly specify
>>>> it for the target.  Modify migrate_mode() so it returns the incoming mode on
>>>> the target.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/migration/cpr.h |  7 +++++++
>>>>    migration/cpr.c         | 23 ++++++++++++++++++++++-
>>>>    migration/migration.c   |  1 +
>>>>    migration/options.c     |  9 +++++++--
>>>>    4 files changed, 37 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index e7b898b..ac7a63e 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -8,9 +8,16 @@
>>>>    #ifndef MIGRATION_CPR_H
>>>>    #define MIGRATION_CPR_H
>>>> +#include "qapi/qapi-types-migration.h"
>>>> +
>>>> +#define MIG_MODE_NONE           -1
>>>> +
>>>>    #define QEMU_CPR_FILE_MAGIC     0x51435052
>>>>    #define QEMU_CPR_FILE_VERSION   0x00000001
>>>> +MigMode cpr_get_incoming_mode(void);
>>>> +void cpr_set_incoming_mode(MigMode mode);
>>>> +
>>>>    typedef int (*cpr_walk_fd_cb)(int fd);
>>>>    void cpr_save_fd(const char *name, int id, int fd);
>>>>    void cpr_delete_fd(const char *name, int id);
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index e50fc75..7514c4e 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -21,10 +21,23 @@
>>>>    typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>>>>    typedef struct CprState {
>>>> +    MigMode mode;
>>>>        CprFdList fds;
>>>>    } CprState;
>>>> -static CprState cpr_state;
>>>> +static CprState cpr_state = {
>>>> +    .mode = MIG_MODE_NONE,
>>>> +};
>>>> +
>>>> +MigMode cpr_get_incoming_mode(void)
>>>> +{
>>>> +    return cpr_state.mode;
>>>> +}
>>>> +
>>>> +void cpr_set_incoming_mode(MigMode mode)
>>>> +{
>>>> +    cpr_state.mode = mode;
>>>> +}
>>>>    /****************************************************************************/
>>>> @@ -124,11 +137,19 @@ void cpr_resave_fd(const char *name, int id, int fd)
>>>>    /*************************************************************************/
>>>>    #define CPR_STATE "CprState"
>>>> +static int cpr_state_presave(void *opaque)
>>>> +{
>>>> +    cpr_state.mode = migrate_mode();
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static const VMStateDescription vmstate_cpr_state = {
>>>>        .name = CPR_STATE,
>>>>        .version_id = 1,
>>>>        .minimum_version_id = 1,
>>>> +    .pre_save = cpr_state_presave,
>>>>        .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT32(mode, CprState),
>>>>            VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>>>>            VMSTATE_END_OF_LIST()
>>>>        }
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 834b0a2..df00e5c 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -416,6 +416,7 @@ void migration_incoming_state_destroy(void)
>>>>            mis->postcopy_qemufile_dst = NULL;
>>>>        }
>>>> +    cpr_set_incoming_mode(MIG_MODE_NONE);
>>>>        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>>>>    }
>>>> diff --git a/migration/options.c b/migration/options.c
>>>> index 147cd2b..cc85a84 100644
>>>> --- a/migration/options.c
>>>> +++ b/migration/options.c
>>>> @@ -22,6 +22,7 @@
>>>>    #include "qapi/qmp/qnull.h"
>>>>    #include "sysemu/runstate.h"
>>>>    #include "migration/colo.h"
>>>> +#include "migration/cpr.h"
>>>>    #include "migration/misc.h"
>>>>    #include "migration.h"
>>>>    #include "migration-stats.h"
>>>> @@ -768,8 +769,12 @@ uint64_t migrate_max_postcopy_bandwidth(void)
>>>>    MigMode migrate_mode(void)
>>>>    {
>>>> -    MigrationState *s = migrate_get_current();
>>>> -    MigMode mode = s->parameters.mode;
>>>> +    MigMode mode = cpr_get_incoming_mode();
>>>> +
>>>> +    if (mode == MIG_MODE_NONE) {
>>>> +        MigrationState *s = migrate_get_current();
>>>> +        mode = s->parameters.mode;
>>>> +    }
>>>
>>> Is this trying to avoid interfering with what user specified?
>>
>> No.
>>
>>> I can kind of get the point of it, but it'll also look pretty werid in this
>>> case that user can set the mode but then when query before cpr-transfer
>>> incoming completes it won't read what was set previously, but what was
>>> migrated via the cpr channel.
>>>
>>> And IIUC it is needed to migrate this mode in cpr stream so as to avoid
>>> another new qemu cmdline on dest qemu.  If true this needs to be mentioned
>>> in the commit message; so far it reads like it's optional, then it's not
>>> clear why only cpr-mode needs to be migrated not other migration parameters.
>>
>> The mode is needed on the incoming side early -- before migration_object_init,
>> and before the monitor is started.  Thus the user cannot set it as a normal
>> migration parameter.
>>
>>> If that won't get right easily, I wonder whether we could just overwrite
>>> parameters.mode directly by the cpr stream.
>>
>> I considered that, but parameters.mode cannot be set before migration_object_init,
>> and some code needs to know mode before that.
> 
> Ah OK...
> 
> I wonder whether it really helps in migrating this mode at all, knowing
> that no other mode should be there but the cpr-transfer mode when with
> -cpr-uri cmdline.
> 
> How about we use cpr_uri to detect early stage cpr transfer mode, then
> after early load stage we unset cpr_uri and always stick with what user
> specified (instead of special casing NONE mode)?  Then it looks like:
> 
> MigMode migrate_mode(void)
> {
>    /*
>     * When cpr_uri set, it always means QEMU is currently in early
>     * cpr-transfer loading stage.
>     */
>    if (cpr_uri) {
>        return MIG_MODE_CPR_TRANSFER;
>    }
> 
>    return migrate_get_current()->parameters.mode;
> }
> 
> Then we don't need to migrate the mode either, which is good as it aligns
> with other migration parameters.
> 
> Would this look slightly cleaner?

Sure.  Mode does not need to be sent in cpr_state.

- Steve

