Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA23D0EE25
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzx5-0007aY-Dy; Tue, 25 Nov 2025 15:47:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vNzvf-0006xl-QK
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:46:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vNzva-0002yQ-N2
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:46:25 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APKWJUK3991374; Tue, 25 Nov 2025 20:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=MAAj3aXCGgN2l/yuJuKF1RnYZ+YpLkf22poQIozWyVA=; b=
 OMF7Bpma+oAHOr5aO1qXpNPXSYmiQ4oN6QwvrvwtXStVw4igE3PeX0iekCOvJcIJ
 H6QWx6yXWYMEdv2GNJIZI5ZYzAQVPGLoXoogPGA+i05D5Ae+IaXYhMSi/02TC8eb
 vE6PurIpyykMvTVOUt4hz/mLmup+zQY1YD/PqjYU9XNkbue6vx1o10xRvOwL1oz8
 hNhOLJgAZ3XbN/XiyBAVf/nz7lV2LytUmfcst7fmafeNYP6mqUctkww5AEqoPd47
 85PLF8NwZlGR30ws2A202kFXhpZlleGFOxcxV9JCW/BIhj12+80FDdZLwEXxzdPz
 D6f92fUkz8ckV4PinEJ0Fw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fk8150-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 20:46:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5APJOXbh018896; Tue, 25 Nov 2025 20:46:15 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ak3ma293k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Nov 2025 20:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1gtAAqtk+k6pwZ+DNA10TzRkUWoCZMAsB4NYxhGUQRy/IaSofpTR7xyzVVfWMOPqmU7/Tdcf/IlhcUkRXbZUEiTgv6Fipt7zU4ioa4lb1/KHqwgVSwJ3jdBJR4VyFX8CuwlxpvjryeMnKYdnAQ5GXBSl1X0EGFJ5KGeCfn7ATbHmw/yFZ8iHU+lkEyikPoEGkIjXz8XQ4uNKJAfmoXVuEXbSmgTTwsOq7KupCGdtEP3rJgQJY9q09lRQYUZzsHZ8wZAiVpwAlbocTOnSFcLY2HMFpAkGMiEa5lSZ74XqbypZN+PZGKgdEgDcMce3gWpdJ9hMsi4kSXpWepyT2rhaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAAj3aXCGgN2l/yuJuKF1RnYZ+YpLkf22poQIozWyVA=;
 b=fZzHXrdGs2B0A0/7Js2J3zRdd/by7Vqiz4RxS62rLtq4jgnZunEAkmshg60BRfgI8IJgEtV/prVb0tiF3yVrQF6SY6/G1P5QuqViXscTEtLrw6B9qt0S/JtDVCfMS3nQ6bbQx1xbg9cizC/hlxWzC+pfIEMtxdTKJ0f44BF3J2FF1pKesEoNupm1K385Qht9dv3Jfbg8sp0xjAbV88WkX4PYG4+JUygY9+iISp1a+JlRT/xYBWns94oifdDRyejnv81iisJBOXk/NbofcHePSLuz18OCPb3FkaeBqXus2apaPaXJxJndpTRj0eCdhDAMvHCw/ZTCHm+1tgsK5LMu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAAj3aXCGgN2l/yuJuKF1RnYZ+YpLkf22poQIozWyVA=;
 b=NS5n493eFDvzaWxaoGfQxXjWzxc96PBn0YRJFRoOrmEP0z+EtDuTu3//+wjdKQDCHvHnwOTfcHdSWUb855124mFpMeJK23Uw+vjruxqYletnum4Fg+h0yFrIk9vijl4HlrRdepGAcqIlbqhkoD5mdy8m/s2QwJ9tfXgWynBwb9U=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 SJ0PR10MB5768.namprd10.prod.outlook.com (2603:10b6:a03:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 20:46:11 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::721c:7e49:d8c5:799c%3]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 20:46:10 +0000
Message-ID: <778c6a35-4b8a-42e9-8af5-6585a7facc7f@oracle.com>
Date: Tue, 25 Nov 2025 12:46:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
References: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
 <e44d1f5a-9e0d-4b0f-97bc-6ece9a36c5f5@oracle.com>
 <PH7PR12MB85950C4310D80D0EE4DC9894F8D1A@PH7PR12MB8595.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <PH7PR12MB85950C4310D80D0EE4DC9894F8D1A@PH7PR12MB8595.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|SJ0PR10MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca150c5-4a47-4636-5517-08de2c63aa0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VE41ZTZXeEppclhqTnRsQkFNRW9TSVNxREprT1FPak5BNGNSamVuckIxYkFv?=
 =?utf-8?B?N1NDampaa3FJcVc4MVR1KysxbjRSNk5IZHBlOVBlZExaYlgvd0ZFVnAwb3U4?=
 =?utf-8?B?WnBkdHJHWTRFK3lIYmZUZHU5RnhxdHlGZDBHYU1NcWx4aWIrUy9WdXk3V3I2?=
 =?utf-8?B?cFIzc0NTVlVNbUNvS0pIR1NHYlBiQjNsbExyVEdwSWMydThlMzJUVTZvWldn?=
 =?utf-8?B?V2ZkMm16RHZwYndNVjU1SVJybjRtK0pRcGV1QjBubE1LYzhwUVl6ekJubVNI?=
 =?utf-8?B?QmRDYXBVdWh4SHJFQ1pQMk9MV1JJS2c0ekl4OW5aQlNRdXBIaGkwK2ZjbGFw?=
 =?utf-8?B?NjlVNzFKM095YjVzQjlTc3ViNlN2NFRXL1FLWkt6cVFDdEI1K1NvN2EyODds?=
 =?utf-8?B?d3RJUFkvamExZGdrOW4wWXNPcU5neUI3K2hBeXp3NUczbFZmT25GZEpoRFdB?=
 =?utf-8?B?d1NRTXRHZm9TU05ocFhkWUFHSDg0OUtETTdvMnAxTGZZVC9hY2RVb0tNOFhH?=
 =?utf-8?B?eGluM2ZRYUd1TG9zVldJRDZ0aDFqcnloVmZXZHcvV3E1NjlxWEp0K3kzY3V0?=
 =?utf-8?B?VE5keXJoUFo2ejZhMEorQnBkSVhaT29HSi96cmNYVlNlTFBGL0tBNzN4QWdU?=
 =?utf-8?B?Nm1XdFA0T1k3dnZoekMrMTRIVVhRcXNTZG94VE5SYzFOSXptdXBlU1g5d3Fj?=
 =?utf-8?B?UkxkU0VCRXl1TVllL1VXRFJRNThIM09FT0lVdmx5eVJ5aUhtRlgvVVJ2Y0lz?=
 =?utf-8?B?SXVzamxkdkhlM0l5YlQwc1pMS0VPY0s0bEdwRGdsQXN3K3NBNW1wOXlQTDFt?=
 =?utf-8?B?em0vRVpmUmJwSGk3Um53Yk9JWElQTC85Y21KVXZjV2cvNnVCQnBZenV0ZjZC?=
 =?utf-8?B?aFkzZ2toemZjeng3Z0xmTzN0MkhDRThXSUkrSWpZM2FTQ0xGK21HeWhGWkZK?=
 =?utf-8?B?YlM2Q2phUFdRbkUySWk3TWx1LzFpdmxlbG4ycXhvdkdhQUdkcExMWml2WHlv?=
 =?utf-8?B?QzdQaWZ0T3BycVZISlg0QnhwQWlDWTVxMVJOTGord09iMGMxWTBYODlTcUcx?=
 =?utf-8?B?elREZUtoVjBINnhKa0M0ekc0ZXVvOFE4S2k4a0pBTE9ORWZXNnlvT25scTBW?=
 =?utf-8?B?WGxNN1RpaFFwUTM5NUpKMTM2L0lmZEhVYWhBbjV4V2o0cDZLUGpHYldZMVVX?=
 =?utf-8?B?eS9lOFR1b3AzOGtTdDFCRUFWNU9IbXRwZXYvMGlGeHJ5dW4vblNiTDI1eUNF?=
 =?utf-8?B?eHpMWkZZeHJ0YXdXY04vdnlZYk9zTDFmclRUelJjUEdTT0hmTS83a0VybVNT?=
 =?utf-8?B?SVZ0WWdZZFo4MVpzWXlCMkpsend5N0Vta1BzNzhxSGV5UnRvRWg0OTJVeU9s?=
 =?utf-8?B?ZFdrUzROeWtlUVY5d0E2Z1pBZUszV3ZIRFl6QWYwUERNWWhBMzRVVUhNMU0w?=
 =?utf-8?B?cllPTE5xL0EzeWxJaVlkbllMWERCZ25pcmNuYVB4eXVpQmdsZzkwdDNrRGUy?=
 =?utf-8?B?bUxCSFhmcUx0YWROcGZIeE1YNmsrUW5BSFpjTXdRSEhKMUpPbGF1d1BlSUJI?=
 =?utf-8?B?cmpQRW9tUGdKYjg3VjVMbXRLMUYxQXIxbkhGVlhKM2dxaFBEVXF5TEZzNk8w?=
 =?utf-8?B?MytBN0NzN3lMaFFCSFVKME4wS3pCY3N6cmt4d29WeC9iaTk1TGZ3NHYwQnJ5?=
 =?utf-8?B?T3FNNklTL3pHaGpvaFRNUENCK0UzUXI2SjVCTjQxY0RGMzUraWpGcHQ2NUJs?=
 =?utf-8?B?TkdscjVLYjRHZFY5VUo0ekVYaU4zQkRLVmlTTysrTDBJbjRac2VGZTlFK1M1?=
 =?utf-8?B?VmpKTGdycXEzSUdLSFNhbkpMdjlOWGdxTjlKaDJiclFPdlp1TWdlVEIzaE1G?=
 =?utf-8?B?QVVWVHNIbjl0dXpVMmxLZEVpL2ZtWm1tcG5xd3hLejZqVG5FSjlHTlNjdFk0?=
 =?utf-8?B?R1E4Z0dvb05QNTh5d29zRzFXK2FWWi90Y1BsKzgwbmpBdFg1cVJJR2RWYTl3?=
 =?utf-8?B?SGhIOXhtdndnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhCV3ZtYUZNenlGbC81UEErTlFwQ2ZURG12OERwRGExZDBpNEZ4ZERNOVQ5?=
 =?utf-8?B?djNuV0FkK1djRi93bExrVUUwc1U3RnA4clNRcHBmWFRoTDYwQTZLMGhlRmE0?=
 =?utf-8?B?Y1NWUTFjNllLMm9zek1rYURNTDZyeWFYTDZoQ1FSS3BvWXErUDhycEwzemcw?=
 =?utf-8?B?dFRYNVFHRUFVTHhNUlNqaFE3U0ljalg4M2pkVithSHFWUkNkZjJWU0UrNUJr?=
 =?utf-8?B?NVVGUmNBSkhtelJ2MDBlMHpmRDJYa2trUU1CbGpQUnJrN1p2QXRPV3Arb0ZH?=
 =?utf-8?B?OWJ6enh3WWZQQnlYYmlaeGdWUlluT1k2OUVBT0NYaWF4cmhhdnJvWDBKc3lB?=
 =?utf-8?B?OTVwaGxuZDZVTTJVTUNkdEtEVlZnV3JOT3hWZk1DYkhrcFdNb1R3TTdhenNr?=
 =?utf-8?B?YytmWmVwOVlWS3V2eUhIckFUMWY1Mk9pZEk1aXVHOXFGNTRnR05ZNWdZbnhH?=
 =?utf-8?B?dTFYenAxUzhMVytZcnlhQ2xrYms3Q0Nhc29OVE95dTYvbmNwMWxvYm9BZ2kw?=
 =?utf-8?B?UGR3K3l1K2xUM21XcHpEL2dtMStTRGk0QUpQdUVnMGRvaUd3TGkzMzQyWFlE?=
 =?utf-8?B?dlFFRHpsN3Y5Zkh3RHBJQVMxMkZoc1ozRWVNS2dmb3dkOGx6dDRZRDdzT0Qr?=
 =?utf-8?B?MVZYNnpLSkJBMVJlaWI2QXFHUkJIOVVaZEhMeE5ZdG44dlN6dG4xdCtxbVJ6?=
 =?utf-8?B?UCtXdUVPM2tacGVOR2VNK2U3MGpwTXRNSUZPbkJ3VGlCVERrMTVSRTZ3MjdM?=
 =?utf-8?B?aVNFVS80MHRPL1Z0N0RxZ3VNbEdib3ZZckJpMkZLczFQZ21ac1B2bU8vK09M?=
 =?utf-8?B?L3BLSXZWcXc0eFRwMHc2RksxaFZ6UXdMTkg2N1lLSHFmQitUUVhpM3R5bHQ0?=
 =?utf-8?B?RDBFZ3VPMlozbVVXaWwxYmhIUjBSWVBsV1F3RnREZUFRdnEvc0lSLys5ZEMw?=
 =?utf-8?B?QTBBUUlCVUs5VGVaeUs5OGo1c3lqY0NIRDcvRVRhWDAwRlFueGZtUmVKbzVE?=
 =?utf-8?B?OUR0ZnpXNE1GbVFVMXl6dUlEOTduOVNlVWFTaE84VWpKdW1DV21nV3JIQWxt?=
 =?utf-8?B?Ynd2TWpCdHVqd2hnZ2VJU2hhTThrMHhUVUpPTG1HNHM4cDNDeUlxcDZFdmhi?=
 =?utf-8?B?aGwxLzd1VXBEeWc2TEJDTmRQZGpuU0Znam5TdnUyeFY2VXc2UHduczU2UUVW?=
 =?utf-8?B?QmcxdmFsVlhhaTlBZTZWYkFHTlRESk9GWGJZT0VlRjVBUEpwVWJGK2czcXRR?=
 =?utf-8?B?REtLdW93ODBWdzkzN21Vb2FDblArMUdGTTQ5dUFtWFlyMjlJeTNydUpMZ1FC?=
 =?utf-8?B?QURhM0QzYklIcCtyMXc1RHNYNTNEM050dUp0WGR3c0NTQ2IvY00wZDNVZDl2?=
 =?utf-8?B?N1gxWm5MME1HbUhsWTdKVUt3dk1TdDQrY1dQMU9IVXlzYmJYM2YxLzlJZ3R2?=
 =?utf-8?B?TzlNdG82SHVRTTR1NmxYKzhlTDhkSS9jZU10eTVSeXNzSlFYMCtxY2dPa25W?=
 =?utf-8?B?d2JaYUM5NEpuczR4a2Q3VnNSc1ZSM0pROUJ5ZWtvN1VEZFkrRDN1dnc4UFZD?=
 =?utf-8?B?eWVZT0kvdTF2V2hOU0dKKzNTY1NHVkp0eHc5ZWVNRGs3SHV4LzdHV1RGRm1i?=
 =?utf-8?B?bytjakVIRHRlRXdsZWVRSmRIMFVFYTJFUEptUG5FcGUyK2pYeTBhRys5UFlr?=
 =?utf-8?B?NG5IeDhJVzF6elVxdkE4d0NGL2ZvZ1hyQWNUOWhZM3g5OVJhS01mNHlRZmor?=
 =?utf-8?B?aW9YNUJBaGIwbnNKVUtnMGZtNG91Rmt2MUlEV1k0M3N5Y2FBWjB6OE04QzR6?=
 =?utf-8?B?dENTMHRjM25pVXJ2K0p4TnA5SVNTR1d2VzZFeXh3U0JDUE90bDhBRXNSdnkz?=
 =?utf-8?B?cFBKUjZrUzNqamNvS3YwbGhpSWh0NklySzlGREFydXd3MUtWdGNKTTRRQ1VP?=
 =?utf-8?B?WWZ0amNNRXhxUzF1VUsyOW1uSWxsbkc1UU1zUVQ2bEFSNmtiSnlSYUJHVXJN?=
 =?utf-8?B?bjdibjJ2QzRETzl0UlV0aEZ5TDVUNkw4eU1xNWVNbHZxbUdmUnI2ck13aUZO?=
 =?utf-8?B?WXRVei9PelM0Y3Avay9tY09jOFNZc0ZUR1A5VjZ5MnBwaFRTd3JuVmljQ1ZN?=
 =?utf-8?B?OW9aTVV1VCtHZit4MnVKT0hyek93Y1dzN3o5M2d5cjUyR1d6cXMzaFVsNTJQ?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oCLbcc+dWZNd3Ph+y/YOi6/fxXGlGmkEv/rHxT9Siok0N9gWQZDg9oiIgzDI1F+lYelrKSjWqQF0jQzwqeG1ivg0yLtT1x47oIM89bJX/PCVmmUwEl/5l8NOxeH0PXj47tsyMXjOnYfFKbMFqj74B3IFBiX0BGHzqa2u2Ezd1CnBEYAvCRM6FgiW5fxwGd0tubOwA4mCD4LmKIIpNtcElX9KlZeUmR5oNdxxFrZ4WrInq6sT5y9ARKicOQejnR5xOZ/sN0eDwUIr/DHoTxfEDNfkFrleUjvcPI0w3mWeCTZN97CtxQdMi3AJC4JguDr4GSgImjYZ+bYZt/MWuD48Zq5yzwGDPvJXMprmJQATu52JEHgJI5t7W8yd87vlUu3PR1S8vqsW7uDW2CzJXzQdGOuJuvfayR1XTAL+izRtzuryWeScRh4mAJNy0XGqqUVQ8Qz3wsUcjm4/CtmkzxzW1fnZ2WWy+LY9x9Vd82eGzN6hm7EzrYM10ksGQvnn6qhdyRPzwui3JW9ppoYuiGqIfktMIWAs6i90cuqkrvf21KYqOVJur6n3adFGo/0X/Dr8Df7AhHQPM0fK8nP388Nu0mVuUp41ZGcGyxdIQ/6Ades=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca150c5-4a47-4636-5517-08de2c63aa0e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:46:10.1972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wl8wPNUYuHmS8NsGCvbHjzidN80Wf2/SRZL9Z+gcWCDz2uMA+lUrrVwwKvVW+Yx0EoaOWVcJ7NDKmTLEXs6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511250172
X-Proofpoint-GUID: ZjMzevpgOaQDW8-xh3C9OEbt0j4FP7Td
X-Proofpoint-ORIG-GUID: ZjMzevpgOaQDW8-xh3C9OEbt0j4FP7Td
X-Authority-Analysis: v=2.4 cv=L+8QguT8 c=1 sm=1 tr=0 ts=69261598 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=69wJf7TsAAAA:8
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=U3yL0tShAAAA:8 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=zrKKWKq4stBl55rdu60A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=BPy96zFGLgaoz4C9NgZ1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE3MyBTYWx0ZWRfX8QBMhq0PUIYH
 M7BAWWTyAz7e34/9/3ZlB7iVvl9vsLE5f4AIElOegTkffN2zmTvFB6GezKHXlhRfGb27fsV3kpd
 XTUSstDB/K3qbxowB5E2cXH+jVwAIi8GO6vLndmEDIPmPrKP4VXUQVGx6KLY0BAE9cu9RLR0jU6
 env35v0UmiUW/Y0/jTOUeS4wUMXO6BvFeb3y6WW8Xaif1/LQl2M4Y2u0eZ5YhqZchXmRfkfggDu
 +U2AdTsmYBxhgEwEicpXmEzUXkT9aVVM+/dqz63/9imAwYAujyqY9VqjYBUJ7a9Rj/3uEIlZ0sC
 mw5xTE499vj1mz4IJal/jKdXxehHewXxHfzHv15mixeQxE33E1y4yv6A1FZJ7kFDsejq2FNVekP
 lqM5Pd/7ScVbQtdEHKUkkYM6dlUw5Q==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi Peng Ju,

On 11/24/25 6:34 PM, Zhou, Peng Ju wrote:
> Hi Dongli,
> Thanks for your reply.
> 
> As you said in https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20251009095831.46297-1-dongli.zhang@oracle.com/__;!!ACWV5N9M2RV99hQ!I2xVB3T2iW4xtnnYdW0e-tnS2cRMe_EuIFx2ALBZ7Ys1lZGS1fyeZ3eYxf21kSU_VVhNkkl0FHIpHFe-U5yIxg$ 
> timeout occurred in guest after live migration due to the monotonic time jump ahead.
> 
> Hi Qemu team
> Could you help to check the patch again? 
> (I think Dongli's patch is better than mine.)
> 
> Timeout can be occurred in the following sequence:
> 1. Send a job to HW and start a timer
> 2. HW response an interrupt (which means HW finishes the work) and VM suspended without process the interrupt 
> 3. Resume the VM after live migration with a long downtime (may be 20s).
> 4. Timer timeout

Regarding such scenario ...

General Linux kernel uses 'PVCLOCK_GUEST_STOPPED' to notify guest VM that clock
may be unreliable for a short period of times. The guest kernel then calls
pvclock_touch_watchdogs() to avoid any general timeout.

Regarding a specific driver, it depends on its implementation. Usually I/O
timeout can recover once the request is finally complete.

For some very specific scenarios, perhaps we may need to resolve it case by case.

[PATCH RESEND 1/1] x86/smpboot: check cpu_initialized_mask first after returning
from schedule()
https://lore.kernel.org/all/20211223210343.1116-1-dongli.zhang@oracle.com/

Thank you very much!

Dongli Zhang

> 
> Thanks in advance.
> 
> 
> ---------------------------------------------------------------------- 
> BW
> Pengju Zhou
> 
> 
> 
> 
> 
>> -----Original Message-----
>> From: Dongli Zhang <dongli.zhang@oracle.com>
>> Sent: Monday, November 24, 2025 3:14 PM
>> To: Zhou, Peng Ju <PengJu.Zhou@amd.com>; qemu-devel@nongnu.org
>> Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Ma, Qing (Mark)
>> <Qing.Ma@amd.com>; marcel.apfelbaum@gmail.com;
>> richard.henderson@linaro.org; eduardo@habkost.net; pbonzini@redhat.com;
>> mst@redhat.com
>> Subject: Re: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after live
>> migration
>>
>> Hi Peng Ju,
>>
>> On 11/20/25 12:44 AM, Peng Ju Zhou wrote:
>>> Problem
>>> After live migration, the guest monotonic clock may jump forward on the target.
>>>
>>> Cause
>>> kvmclock (the guest’s time base) is derived from host wall time and
>>> keeps advancing while the VM is paused. During STOP_COPY, QEMU reads
>> kvmclock twice:
>>> 1) immediately after the VM is paused, and
>>> 2) when final CPU state is collected.
>>> Only the second (later) value is migrated. The gap between the two
>>> reads is roughly the downtime, so the target restores from a later
>>> time and the guest monotonic clock jumps ahead.
>>
>> According to prior discussion, it is expected to account live migration downtime.
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-__;!!ACWV5N9M2RV99hQ!I2xVB3T2iW4xtnnYdW0e-tnS2cRMe_EuIFx2ALBZ7Ys1lZGS1fyeZ3eYxf21kSU_VVhNkkl0FHIpHFePWcT4Fg$ 
>> devel/c1ceaa4e68b9264fc1c811c1ad0b60628d7fd9cd.camel@infradead.org/
>>
>>
>> That is, the jump forward is expected during live migration.
>>
>>
>> I used to send a QEMU patch to account live migration downtime.
>>
>> [PATCH 1/1] target/i386/kvm: account blackout downtime for kvm-clock and guest
>> TSC https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20251009095831.46297-1-__;!!ACWV5N9M2RV99hQ!I2xVB3T2iW4xtnnYdW0e-tnS2cRMe_EuIFx2ALBZ7Ys1lZGS1fyeZ3eYxf21kSU_VVhNkkl0FHIpHFckXGguCA$ 
>> dongli.zhang@oracle.com/
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>>>
>>> Fix
>>> Migrate the kvmclock value captured at pause time (the first read) so
>>> the target restores from the actual pause point.
>>>
>>> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
>>> ---
>>>  hw/i386/kvm/clock.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c index
>>> 40aa9a32c3..cd6f7e1315 100644
>>> --- a/hw/i386/kvm/clock.c
>>> +++ b/hw/i386/kvm/clock.c
>>> @@ -43,6 +43,7 @@ struct KVMClockState {
>>>
>>>      /* whether the 'clock' value was obtained in the 'paused' state */
>>>      bool runstate_paused;
>>> +    RunState state;
>>>
>>>      /* whether machine type supports reliable KVM_GET_CLOCK */
>>>      bool mach_use_reliable_get_clock; @@ -108,7 +109,10 @@ static
>>> void kvm_update_clock(KVMClockState *s)
>>>          fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(-ret));
>>>                  abort();
>>>      }
>>> -    s->clock = data.clock;
>>> +
>>> +    if (s->state != RUN_STATE_FINISH_MIGRATE) {
>>> +        s->clock = data.clock;
>>> +    }
>>>
>>>      /* If kvm_has_adjust_clock_stable() is false, KVM_GET_CLOCK returns
>>>       * essentially CLOCK_MONOTONIC plus a guest-specific adjustment.
>>> This @@ -217,6 +221,8 @@ static void kvmclock_vm_state_change(void
>> *opaque, bool running,
>>>           */
>>>          s->clock_valid = true;
>>>      }
>>> +
>>> +    s->state = state;
>>>  }
>>>
>>>  static void kvmclock_realize(DeviceState *dev, Error **errp)
> 


