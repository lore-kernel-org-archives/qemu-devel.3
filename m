Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A77F54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52l3-0005iR-Ok; Tue, 24 Mar 2026 10:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w52kz-0005i0-CV
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:29:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w52kx-0005GH-Bd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:29:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCCGj21539894; Tue, 24 Mar 2026 14:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=cB3GO24ZwC2tnEIJ3I46uOx52Y3l3HvrgauuRw71Ojc=; b=
 A/mAT2g6kx9oTIsELp3QByyVOcEdo81f1D4YOVaVRUeEeZl0wdNh1lncLrIZns6S
 SEtvM1g6D82laLMHBRWj/u5HgmysyV/fElInrygTtl5fBCR4CxBgxBIKingnjpE0
 kl14ZuW3/QmgCAZ1XdcOaytJIiLe2vVmj8FfYGv3HIhmU7DNCb5T4c0zsHBoQxjl
 WwSYJw5omO00dwqNwkQiiDkL/Eo3m5su4Lsj9eElMve8YFgNoG3uSd98UWakHihw
 gu/49nQs5CNZ5vImy1UXLws+CFwRbMabJasP2oPSi3Vz5ahG1NOGdl/Z1AgzrrA7
 ARhxEOXmXUVbYgTVuxrK/g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kja4bye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 14:29:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62OEQhxJ039071; Tue, 24 Mar 2026 14:29:02 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hsa3r26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 14:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRZ9AhYiafXNEWCZfvlzPyi6x5jOmIwcvmnwR7f6lE6X7GtBuqiP5MpCyxrgapjpLccWoZueQjdtCHCN8wk0iNvrRxCAeUmT+Z/iO3Y1zECCBcbsXbl5La3NJ3aTIE91cSfLaLrlKMpRi0dlRwwqAZEjbk9KMnD0puk2S47lT1zpSVRRNfwkGPwtc9X8uIFMEquTX9QJeK6OS7pJGDf/Wz7L76N+tba2U+my551DichR7YjYBoxK6AyCtMQk1FRsh14AMLanMb0k7i2TCMb9VjiyHl/7QfnoyHnqEO5Swm3cElOkiPlMIPve6q7FnphXobzFg6SjCfUqqnkL18yFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB3GO24ZwC2tnEIJ3I46uOx52Y3l3HvrgauuRw71Ojc=;
 b=GgGZxnl7xiVu0fDC9ViFqw1jqTJIG0b3m3qEl3Zu4/1GMZYL6Vzr49tAaypCtoc7JNGOw1F/TyssGrz20ArynDcBKaVuabJAwN7/A0UkgPFII+ixcaADX9P8SRDQR5MCHJh5i/o/ciK+UlFcfPDFxqbuf4S/fIdfFNPTokhD3Tc2cgIlHcCzsy8+uds3y+F4AqhQukjJuV/jtJfGVCm8Ourvyk78WGbW3KtZYVvk+AES7+/WeR0f+Svn9rWCY3I4a9h7mJDg6LcxpXhGj6iZFUMF4H2o4hKJ6qmXPlLElBxXlnYQ2ieaBwi6u5PgenO3IhoB07rEe0deNo6330SgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB3GO24ZwC2tnEIJ3I46uOx52Y3l3HvrgauuRw71Ojc=;
 b=xesd2nUSbM1C3DBsU1JzcsmnhI96KIEFxQCd16GARkc/DBKlGkgvF9zfwAPUyXRrnTuCoFXMfDYmckKEA9v0mQpjDPFtZhww2wiQZprij1istlxdqxXqngbdSHbhjgOIGCG3Cri3vBOrhE9vTPtXCc3ybToDPNJYtoVd9T7m0r4=
Received: from CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7)
 by MN6PR10MB7443.namprd10.prod.outlook.com (2603:10b6:208:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 14:28:56 +0000
Received: from CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f]) by CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 14:28:55 +0000
Message-ID: <cf9b156f-725c-4443-b25f-b82911cd10bc@oracle.com>
Date: Tue, 24 Mar 2026 10:28:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 02/14] virtio,virtio-net: add initial early VMSD for
 setup-phase migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-3-jonah.palmer@oracle.com>
 <CAJaqyWfsr8GUfcXPz6xwcXn3TA2_k4o8+_ySr6znExj34p5VtA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfsr8GUfcXPz6xwcXn3TA2_k4o8+_ySr6znExj34p5VtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::24) To CH2PR10MB4360.namprd10.prod.outlook.com
 (2603:10b6:610:ac::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4360:EE_|MN6PR10MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 3794e287-42d2-4ffd-a190-08de89b1aded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7WwqInXUF8c1BGekD3YVfEXHLcEPA66ush0c4B0ItI0pyB/MzwjzXDRHgsUySlU1vdOSnrA8ICvF1wG4hufMZXL86BnyI8mWvTqvI+9k4Hm7ZeQCVkfJGvfydfEsxdJavLPlitRa8gFdNdmfwiUdw70DHbWcueqfnCj4iTCmHck9xlSNA4TFs45nWesOSeyDJyey8MwROP5sacnDZlwELzv46mvf7E9qeI4XxyjlZ0upn4lJ0CYHGUl4LWO5wDZJOOtidMZC2aTEaQ18w9fMuIh+QK3VJROu2cdPad+A6Zpb7W9dVzzYKwEgOxM8eRHX/gXKmXQKDYtNBOxG3MIxmsFWjG3zRNS5oZ1AQ7vr/gzBDKgxRY7DjqDPUsuOltLvrjb0sVN1xh9tAZp7zqeQViLHuoi83YpkKbvM9UseJIO0xmQjJa1Ensm67IEYMC5h8/U0z6dpDDVyYWR2CdAQveR3yme5Z5UowZJCvFBx041KHj7WNv4pj0AZ7ept6k+a/RvFijOUhM987ZDDuvoap+32JWme/25SFTSHbPXeZH2X2/SsrJCBxqRLrp/R5nj3/cF+6/INl8kKhiDknbfzdRu9Obi7ItNPPDTB47eP8NMnVh77ufrKryCmyHuyQCxoE++0G2BNjgfvR//hNEBGZPMTANSxgqUKRuW8pv6YAINCB6qpChqjtameEtw4Bv17SQ9b6dcTdH8bQLkZVfdiO6Hipk/PCH+rTO0S7z4XRek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR10MB4360.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNOSmxFeUZTK1FBTU5EWktubW5CTUF5cXZjZU1NQ2p5UHdoMjZ0TGtWVW9Y?=
 =?utf-8?B?YVVxWFg3blpVYWtIbGRVN1czTnNZdXpuaW1WNXJwOW9TTFJCRWJkN3M0M3Vn?=
 =?utf-8?B?WHYwYXc2dUp5Z1FNSnNtWVB6dHBEc0gwaVZwQ1hjVXI3UVhmU1NCS3E0Uitk?=
 =?utf-8?B?bXBRbUxrV2MxcFhPdEQ5NmRxT01Lc2R2ZlNsdmVRWi9Uajh1am0ybFpsS21Z?=
 =?utf-8?B?cFpZVWZpUVpMcjJpODRuYWpDU2FJNXZIUVc4NnA0VnBjdFN2UHNaRE9KbW00?=
 =?utf-8?B?bEdRalNwbUkyTFBnUVFvRi9Qc3o0ZFh1eG5iaFhnZlNycEhQTFhtdjhNODJB?=
 =?utf-8?B?OFpreEtld1NCamZsMGhaOFhxZVZPOXlCY05uRE9DeFNHSjlOdHB3TUN1ZzNh?=
 =?utf-8?B?d1JRTjV6b2NmMVJQNXg4SUI5Yk01aHJ3RWoyWXBXMm44Z0o1d0g1cWFKN0hS?=
 =?utf-8?B?Sk1wdCs5emFRY29tQ3dqM0JXQlE0anJ2MTR4dkVTNlhnYUZ3Qk0zQjBIVURN?=
 =?utf-8?B?bHdtZmN4QnBwdUhSRU1pdk9oMTdGN1ZYRE5SRnBSSnVMMWgzMmN2eGZBRXBy?=
 =?utf-8?B?SThlbmJqaFl3YnVmbVJYS1c4MzBZYlNCZWdHN21TV0ZNL1l4NHpXdnUwRU01?=
 =?utf-8?B?ZkxHNjd6cGFmazlNOVJKRTgyNDZOSmtiOHNoSFBXNk5WN0EyUFRsYXZWM3Mv?=
 =?utf-8?B?WjdJMkdvOGFHdnViQlh3YWlKT3NoVHVHOEEvYldWM2N2L05QZW42dngyc1Z4?=
 =?utf-8?B?WGtYWVlDOXdtTDNTMUtwc3BBYkVGangxNkh0ZGl0b3cvanNLTG1QdDN0UHgx?=
 =?utf-8?B?M0gzVm1mMTYyU083a2VETG0rSng5WmpzREtOekFRblIwOE5vNTI2LzZOZXIr?=
 =?utf-8?B?d1IwejBiRXg1dG9UcXg0ODJxOGVIUmgrM1dJS0pZcnMyL0lyQjlrVDU2Ti9k?=
 =?utf-8?B?MUJHS3VxczVjdWhITTNEc2N4UjNLMkNGSmYzUzltYk91YnN0OGFGT0g1dzJQ?=
 =?utf-8?B?b0dqUnVHQzhKem11Sm5DZHdCdk5CS2RxY1pCODFxemprZVU4M2o4eUwxT1Mz?=
 =?utf-8?B?M2tMdmRBWGZnRDhGV212MjFvaFVMOVVMME0vVFhKTFZUTXdicnZsR1lpcytw?=
 =?utf-8?B?NTJPMXBRQ3hVNGZFWlJ6d1Rqd2NyV0E4OUkrOFRRWEZMSUhHWFQxL1Rla0ll?=
 =?utf-8?B?cjVyNVRHRk4wM2MxT1QyMEdRWGxRdXU0YXFlYzVIR3NNMnRzMVBhRGpZZzBa?=
 =?utf-8?B?T1IxQWFhdTlCbEszQ3ZzUmxrYkQyUWQzUEQrbXBZU281d1o5aStJbWV3Mith?=
 =?utf-8?B?OEo4OHltUlJPejVKZXlyWmEvR1FWQXVoc3dockJYdHZRR21UWHNZcGdXUC83?=
 =?utf-8?B?NXpnZ0h3OFFIa3hjaTNBNnU0ZENuc1pQZDJyTCttK0M0eDQ4OC8vRjZGOWtF?=
 =?utf-8?B?N2ZETXNTTGlvL3dYcUQ4b1VMT29EY1Jmak9QNTFSK2c2emhzQjkxcVVGeGYz?=
 =?utf-8?B?M29rZGhTSzBOK05QZEhpaCtPblk4Vkczb3RpWDhhV3FldDlLRElmc3FMK2dZ?=
 =?utf-8?B?UjRxVEgxbmtnRS9INkpOREIyZVdic3hyTzA3U0lHRDRENUVWY2JGVUdXb1ZU?=
 =?utf-8?B?ZllHWUVFR3d3dVFIaWJZdFVQN091NjZhSm0zMUZ1TVVxWWhraDI5TFFnQ29B?=
 =?utf-8?B?MkJCMWp5ZXgvbEdSYmpGcDhUZGFLUXZ3WTQwa21UekpkNCtGcm1UK2xRVTdI?=
 =?utf-8?B?WGZBVi9qZXZ3Zm9Zd1MvNGw2WVV3dWVLNko5Z2VUelhBOTZsbCs0K0xmcGIx?=
 =?utf-8?B?elhuSlJXd0QzUVFLY2FWMkM3aHpmVW5mUmVad0RGS2VPVGZGZmgxR3JzaU0z?=
 =?utf-8?B?aEpBMXZpcmJ5ekpXeTNLVEpTdm92NzNqVXJxYjl1dHR6V0JVak5jeU1xRlQz?=
 =?utf-8?B?ejRLYzBLZCtoVE5UVTJ4S20vTzk4SzhaVVhxTUQ0V25kVUtBRVV5b1FQQkIx?=
 =?utf-8?B?Uzd2Z0JYWE9lWkUwOXRzSm10eWsvNEc0ZmhNSDZQamVaZ1ZISXNJZG1pMXpq?=
 =?utf-8?B?S0U2OENsa0EwbUJ3TkFaWTVYa0RYTEtkYllFM1VGb2RxNjdnMEhLamwzaFdW?=
 =?utf-8?B?NGtIVGpwVVhyOEJkNUdKOWFwOGhac1d2RzJSSmpRc25ZL0dPc0NGNEJkUlBt?=
 =?utf-8?B?bEFYcHVYb2FzeWVWS2pXaEZDK3hPQlFRZXVPeE9RcFpqZVVEeWN5clF1Ull2?=
 =?utf-8?B?YkxvMXVXdzBHY0ViYmVsWGVGamRwbkFIUGN4Y0cwN3RBMTlQSHJqV0ZodWJ2?=
 =?utf-8?B?UjdjNlJYSElmdGJIMEJXOGl6Tzg3bVZUUnZKSjhSc0lCVFgrT3hrUT09?=
X-Exchange-RoutingPolicyChecked: TSWTX52gJdOORgzlH0+Ul2B8LdHzJEamgKWlqovy1perCNTs+4rooLsAUK+73+a5moaLgd/Z3tjNn36GdVONN2womckL0Vz9aAblBWkGutHqckOuuF4Ub3Urm0qh5Bpj505CdhHBnYXPKzJqVMdjB/yp/zzRAXrPkAqDGX58Ns7BFgH7eg3g3aDp21QKwt3fy4mErlnAKcS0MDVbG1NZ5xVbuNgU9ZA16wYwMfYUqmpU1EkcaJI7WhT9Y5qFAjJ7xu812kz1axE5xDcHmMlPy94usGIpXeVfTKs89qCrZrab78G6KtZqu500nGcLvGMsalz5T8gs+g/zRkVKpbsuAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QuW08rbfUfBj/IloA5l5cRDBflukHVhfbDj8AX2DMEarwVdbPQp9e/wuEDpH30TU6LobifOnVL553mHBTZG3ZVNldJpiSPVPxUCmPN3bhzSiqC34VLJOjmYrZI3v5+trJ2C0bmiLEdw8okzPzA24euTxdxHr5I63GTA7PyWgBl7VtcfptZiV3j/eTDIeR7h+DCnB6QnGftFQUZQR+/yKy8EBMk2oOU9CUccu9oZ68SuuFmvtjvtoD1c7K0zMgMQh1AYrptzQRhs3Z10IiSdcMGnDxTDvnySuzTt2jHhaN9RZHtgqAmzJWNPnHoYbmIdWopguN7/8PxKuYZ7FGYwAqbiyy8DWRyHS4BW2jTHnqUexp4ENw6rg8G6dq+gKyKvRbW9dpHIA9N+7ref13oNeBwvXArvGa7eK0gB5sS00jCX3DDEdTb4yKK1GyJ3ib/bCNPxZRaWzF4Zzg97GRRO+dvEEAMQucrIt3bbH34nLn3XMNGdDY+wm2RWvHD56uqsZEn2B5MkmihIOT+FL/sCyROLkUXhObPG5+dtPpMRXIkpH43ge06sTNDjOygNrtU/84XvPoE8EWGc+yyjAYl/V/KKwHutH5/4W+61wfY3E/Kc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3794e287-42d2-4ffd-a190-08de89b1aded
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4360.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:28:55.7470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzNr5vdIXkyZcSJqt9W3KNbz4dPk3Tjz5xmlLXib1APfBUlTpI+RtTv50u3lbdKnHukpRbsZx8Mn51j5PFrokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7443
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExNCBTYWx0ZWRfX9MEIxFTRkwgF
 aevPjuXIVjpchtYWif/RSigQ7H+goKRJu/rAtzcRuDjp5FmhNj0qIG79JIL1mtyZto56IolH30c
 otaWz3FFv+ciiiESANPawixwL17sPaenOznjxROybLgO+p4AMgpMgZmyOfyTP/pQAzywnaUbOCN
 gkwyQARokAsf8dS1KYSXlhJp7Sysef5A1uSDHoRUgiPknfrQBe5kf9XRozjB9XlYNG2XxVq8RFD
 +QP+psp2fEWd21dZ4r3xWruELchvl/cmtGfz//0tOdTtiyk/tXbEwIo58et/bKqyqjpSveyf6vG
 3t3ujgvQYf8gXRGUvAR4ny/4OI9Hzi8kL6rono+ezZexzlUPXx2uhkOCJCWcpkad2b5xGnyciBl
 jk6tXWotBj6fDw+XXMzCl2vFtYS3BE/ZKRxV6NLsT3xjHt5IEcmLr0w1bRAv0U5lEsd00xm+Q8C
 VlTSA0GE+CR9gTlPbo44zbatB3JTBsSHNNNrigP4=
X-Proofpoint-GUID: _qLo2EJpSUznH3KkFYXWQ0NSzyMYyiDP
X-Authority-Analysis: v=2.4 cv=TPdIilla c=1 sm=1 tr=0 ts=69c29faf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=ZM1eBjWH9s7J4lbWvKYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13824
X-Proofpoint-ORIG-GUID: _qLo2EJpSUznH3KkFYXWQ0NSzyMYyiDP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/24/26 5:27 AM, Eugenio Perez Martin wrote:
> On Fri, Mar 20, 2026 at 3:25 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Adds a separate VMStateDescription for virtio-net that uses the
>> .early_setup feature. With this feature, we can migrate a virtio-net
>> device's state earlier, before the stop-and-copy phase.
>>
>> Future patches will utilize this to move control plane operations out of
>> the stop-and-copy phase to reduce the downtime latency caused by
>> migrating a virtio-net device.
>>
>> A VirtIODevMigration migration data structure is also introduced here
>> for VirtIODevices to help track the current state of a migration.
>>
>> The early_load member is used to signal that a VirtIODevice is being
>> loaded early and to not throw an error regarding vring indices.
>> Inconsistent indices shouldn't be an issue for a device so long as the
>> final indices are eventually loaded before the device starts.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/net/virtio-net.c        | 53 ++++++++++++++++++++++++++++++++++++++
>>   hw/virtio/virtio.c         | 14 +++++++++-
>>   include/hw/virtio/virtio.h |  9 +++++++
>>   3 files changed, 75 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 12b3456ca2..ddd6ed6e62 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3864,6 +3864,37 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>>       return qatomic_read(&n->failover_primary_hidden);
>>   }
>>
>> +static int virtio_net_early_pre_load(void *opaque)
>> +{
>> +    VirtIONet *n = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +
>> +    vdev->migration->early_load = true;
>> +    return 0;
>> +}
>> +
>> +static int virtio_net_early_post_load(void *opaque, int version_id)
>> +{
>> +    VirtIONet *n = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +
>> +    vdev->migration->early_load = false;
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_virtio_net_early = {
>> +    .name = "virtio-net-early",
>> +    .minimum_version_id = VIRTIO_NET_VM_VERSION,
>> +    .version_id = VIRTIO_NET_VM_VERSION,
>> +    .early_setup = true,
>> +    .pre_load = virtio_net_early_pre_load,
>> +    .post_load = virtio_net_early_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_VIRTIO_DEVICE,
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> @@ -4046,6 +4077,21 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>               n->rss_data.specified_hash_types.on_bits |
>>               n->rss_data.specified_hash_types.auto_bits;
>>       }
>> +
>> +    if (n->early_mig) {
>> +        if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
>> +            /*
>> +             * vhost-user backend is not currently supported for the early
>> +             * migration path.
>> +             */
>> +            n->early_mig = false;
>> +        } else {
>> +            vdev->migration = g_new0(VirtIODevMigration, 1);
>> +            vdev->migration->early_load = false;
>> +
>> +            vmstate_register_any(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
>> +        }
>> +    }
>>   }
>>
>>   static void virtio_net_device_unrealize(DeviceState *dev)
>> @@ -4090,6 +4136,13 @@ static void virtio_net_device_unrealize(DeviceState *dev)
>>       g_free(n->rss_data.indirections_table);
>>       net_rx_pkt_uninit(n->rx_pkt);
>>       virtio_cleanup(vdev);
>> +
>> +    if (n->early_mig) {
>> +        g_free(vdev->migration);
>> +        vdev->migration = NULL;
> 
> Nit: You can use g_clear_pointer(vdev->migration, g_free) here.
> 

Ack. Will do!

>> +
>> +        vmstate_unregister(VMSTATE_IF(n), &vmstate_virtio_net_early, n);
>> +    }
>>   }
>>
>>   static void virtio_net_reset(VirtIODevice *vdev)
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 8fcf6cfd0b..48de4a430b 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -3323,6 +3323,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>       int32_t config_len;
>>       uint32_t num;
>>       uint32_t features;
>> +    bool inconsistent_indices;
>>       BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>>       VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>> @@ -3460,6 +3461,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>           if (vdev->vq[i].vring.desc) {
>>               uint16_t nheads;
>>
>> +            /*
>> +             * Ring indices will be inconsistent for a VMStateDescription
>> +             * performing an early load. This shouldn't be an issue as the
>> +             * final indices will get sent later once the source has been
>> +             * stopped.
>> +             */
>> +            inconsistent_indices = vdev->migration && vdev->migration->early_load;
>> +
>>               /*
>>                * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
>>                * only the region cache needs to be set up.  Legacy devices need
>> @@ -3481,12 +3490,15 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>
>>               nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
>>               /* Check it isn't doing strange things with descriptor numbers. */
>> -            if (nheads > vdev->vq[i].vring.num) {
>> +            if (!inconsistent_indices && nheads > vdev->vq[i].vring.num) {
>>                   virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
>>                                "inconsistent with Host index 0x%x: delta 0x%x",
>>                                i, vdev->vq[i].vring.num,
>>                                vring_avail_idx(&vdev->vq[i]),
>>                                vdev->vq[i].last_avail_idx, nheads);
>> +                inconsistent_indices = true;
>> +            }
>> +            if (inconsistent_indices) {
>>                   vdev->vq[i].used_idx = 0;
>>                   vdev->vq[i].shadow_avail_idx = 0;
>>                   vdev->vq[i].inuse = 0;
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 6344bd7b68..4c886eb48b 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -99,6 +99,14 @@ enum virtio_device_endian {
>>       VIRTIO_DEVICE_ENDIAN_BIG,
>>   };
>>
>> +/**
>> + * struct VirtIODevMigration - Common VirtIODevice migration structure
>> + * @early_load: Flag to indicate an early virtio_load for the device.
>> + */
>> +typedef struct VirtIODevMigration {
>> +    bool early_load;
>> +} VirtIODevMigration;
>> +
>>   /**
>>    * struct VirtIODevice - common VirtIO structure
>>    * @name: name of the device
>> @@ -168,6 +176,7 @@ struct VirtIODevice
>>        */
>>       EventNotifier config_notifier;
>>       bool device_iotlb_enabled;
>> +    VirtIODevMigration *migration;
> 
> Can we use something like net "struct VirtIONetMigTmp" for this so
> VirtIODevice does not need to be expanded?
> 

I wanted to keep it under VirtIODevice because it's meant to hold 
migration scratch state that's common for all VirtIODevices, not just 
virtio-net. For example, it could be reusable by other virtio devices in 
the future if they were to implement their own early-migration path.

If we made this for virtio-net only, we'd need to modify generic virtio 
code (e.g. an extra callback) just for retrieving the state. I thought 
that this would be the cleaner way to go about handling common 
VirtIODevice state.

>>   };
>>
>>   struct VirtioDeviceClass {
>> --
>> 2.51.0
>>
> 


