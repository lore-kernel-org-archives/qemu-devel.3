Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E921C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Pv-0006HO-49; Tue, 10 Jun 2025 13:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2Pp-00060r-BM
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:05:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP2Pj-0004i6-U3
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 13:05:36 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMa56008643;
 Tue, 10 Jun 2025 17:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+vVCQyaDJ+H03KYf1pGRFVQjCNuv5ArSwILdD2U4oz8=; b=
 CIrc2nuzWTss+b8a134cykOshixwsilE0OoxAxSEiBVF6O/D+ibwkfdgO84+EOOZ
 lDUlivOS7WNs7bH5sbYukdlNARDFeMAmT+oiNgz3JW0FI5VxZ7GZ5h9q6yFuZr2p
 chpVM4vnMokx0j4IpLSMxKDN4XJheVWC8aeWM+FBSg0AJFdWEsNI9uH8tNKg6hCO
 ZfZMmiHpHcL8bR+AIdRRjNWYPxiPVtC3xNE7QWQjLItSFqAFNl7ig5Tv2Ow3I/1C
 xVfa0zEvxH4lObwNl7ETqi7wjLuPWtjz9UerKiRVHj8qgUHFW7k2BLeBpquHXR7R
 ldkuRWH2wCrsMKL14xluKA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbecpc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:05:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AH2eSD031370; Tue, 10 Jun 2025 17:05:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv90903-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 17:05:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdxcAJwByvMYQezKIbKGyqT4Rj2efYNwPzGFXtoZX3XcRmAoDw7+zibQ5iA4Kf2xs6/0TN5sQCWsESIGbAvj9iMQDldPyEvHk4EHWg68cg5b8BnlIlzV8o7dsysuPs3Mun0bjnokuTkNXCUjXKpGUydtQLTj76hX7gKEkN/CLof+96m9M4LCLhBkT9oeLIPYpPEf5rWS42+saneonAY48thNWwED0gbihU9qOm2dRPWeghQX+BfaL+jLl8qM0J9Sc9QiAyWo/LudmdbEHcdFz4+mFN1oPNu2IRuA5GWI8LKWm4aTsQAjuyHcYAJgwD1dEoxIygVIJXKph0avqAd3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vVCQyaDJ+H03KYf1pGRFVQjCNuv5ArSwILdD2U4oz8=;
 b=l30Dd/m1dURPtYJT/qlpDv70fFGSyxogV4MCEOIv1PQ8fWrwLHtlpuQclHnCyS7W0Ty8jJPAaObx6reMO8Jx0iYmWW+Q0yKgDgiJ2h/a1qqsVxeFQdImzK4N4QArLlEEmWl+xd0wvYSL46QVyvMdr0skxfI97fm/MvIlBsWo3McwVOJ20F+h1qKDNZwbtwFlR0NIynDszNMAy1Cb2x23jKG7V66kgOWvQNHTFbFKMnUcToHFbNpk6i9heta0III3uZyBEbFBF+d9dFgs8wXyBM24V3o/ksOawMn8GeWL1angi5NiCSv64lZE5Gbfd4sza6FWl/+ok4ajBCDTmdK5Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vVCQyaDJ+H03KYf1pGRFVQjCNuv5ArSwILdD2U4oz8=;
 b=ARSEj4x0MzWweL0IafKq086i6gjtNnVzRvHYdnVxVE3v8cJwnt24vYK1ayTucWeHsCZ7LE8zEp189wHBN5dnTVe/mF+wvnhevhM0KzfITuPSgw7xjRarSUwZ3aOL4/jGppNDiDAeyuueYgzL+gautXHUk3cOGlObEKeyKBlwG3Y=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7743.namprd10.prod.outlook.com (2603:10b6:610:1bd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 17:05:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 17:05:24 +0000
Message-ID: <6354f3a8-6309-495a-9014-6f5243a7785e@oracle.com>
Date: Tue, 10 Jun 2025 13:05:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
 <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
 <0a50d630-57c7-4f05-93c7-73be8f575873@redhat.com>
 <c01c7c19-2422-45c7-9582-09ca37170974@redhat.com>
 <468008fc-a86f-4b90-86c3-1109d68f6fc2@oracle.com>
 <76b58b82-a867-4577-8644-88e419a8d85f@redhat.com>
 <20250610122246-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250610122246-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ef2b96-6944-42e9-569c-08dda840fd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0hDa1REbTBYdWhhMmxXS1ExZC8wOW13TGlIclowQjJUSkxqYm9yVkZKTUVS?=
 =?utf-8?B?dGdtWDhOdU41ZWJrU3Y1UGgrd0NONFA4MmRWS1pvTEpEQ3ZOcXZ5SW0xTk8r?=
 =?utf-8?B?OEpYTGFYZTlVZVVSMUh1RkNrbWNxZUp1cTlIcy82SUN6aHRZNEdiQkYzeWMx?=
 =?utf-8?B?Z1RiaC9VVG1iUUNFaXovWSt4Wlk4bDFCNnQ4TlFLRy9oUzd6S0kyNXY4NGg0?=
 =?utf-8?B?Y1VZRG5VUkpHdExZYnRXak9nMFN0OVhkVUhQMU0zUHh1Slg0bW5MOUJCUGxz?=
 =?utf-8?B?N3BKQmp0eFo2RUVSTGlmUU00eUdCSFN2dHpMT1dxQnhiNCsxWURIWXlWVzZU?=
 =?utf-8?B?S2JDVkFyenhRZzFnQWFQQjBIcE5ldGdRcHIzVXFodmhwOXRTWjJMR3hEZ2NW?=
 =?utf-8?B?ejV3SGc1ZGFlSmU0bWlUTm5CSkU1WElkb1pHT1RxS2VoQjRpWm4yaWZ1bktT?=
 =?utf-8?B?L1RSN2hBUUVad2VoQ0RjSmhLMGVhblp0T09kY3ozTkUxOTZJUWVlUlJOS0o2?=
 =?utf-8?B?KzdPTzg0NityNEhRQTFuZEttQzM1MTdwUHJEbEZCYWdCdDczUFZEcjNvTU1B?=
 =?utf-8?B?akVXOUxkeXdkb0UzSjZrUDBRdkFCOFVRSjMrbkFMRkp1c3NzRmRoeDd6ejRD?=
 =?utf-8?B?SVlZejArMXhETFE5RFB4bDB4NVZNOU9DMCsvc3RYVHBFdmIydVNuVytwYUIv?=
 =?utf-8?B?MmIvc3N5SG50YVQ5YVN5M0VrVk9oSEJzSGhlcHhiK1RGUUE0ejRNMzBWUmdh?=
 =?utf-8?B?eDVBZXA5YmxSMHd5cjB0cWRDZW5xWkVadWRQZEx5SlFpSk1HeFR2SHpTYS8y?=
 =?utf-8?B?c3FtUDk5d2d5YkdjV3NoYUpkMzQ0QnIrTjdJZ1hFSm14NHNORmdweVNZcU9P?=
 =?utf-8?B?TnM1dGVDMUxVUkdOalJhZEIzVVR5bUxiSDFxR29IWm14ZFZ5elRrL0VyVVFW?=
 =?utf-8?B?TlVrZWs3V1o5QXg1M0N1Yk4wTzd0bUNZN1dGdUtPSVdESEZqcUZ0TXV5ek56?=
 =?utf-8?B?QTU0REhpYUJlS2xRRGt0ZG8yUkJ3b294VC9CZnNLRkN2d0JQMkJZSG5OVWs3?=
 =?utf-8?B?M20rcnRkQWhzQ0I5QXNmV1ZKRS9vRStvRWMrUFdmbWJFZFlNWmdrSUYyNEZ3?=
 =?utf-8?B?SVdKUFFJdGpJeFVvNjlyaFhCbGtpV2pzSFJuQTY4elowVWF3cnl3UWdjSGxB?=
 =?utf-8?B?RGNPREhBbStoVXZuSGhmMWgwc3pHclhkY2lrT3BvZzFDNnVud1ErZ0kyTnNi?=
 =?utf-8?B?RHR6ZUNGRDdNRWZIUWNDMkxFaWIvbll1aG03akYwTkxRMndwemc0RjVmbFQ5?=
 =?utf-8?B?dDdGaVVoY0NqeVRRKy9QcytBenFoSm1yeks3dGJLYWRGeEdvOUJ1SUVmdTJV?=
 =?utf-8?B?dDdoTVBEVndQVUdvbTc5VVNyRFdsWThOUU1vZS8zZDlpR1lCQ2o1RndtSFl0?=
 =?utf-8?B?RVFZdTNvd0tsSnNnSThmbmw2eXhPZG9OSkc2eCtjY0k1L1FvMEhIdkZJdnBF?=
 =?utf-8?B?eEp3MGY4a0dwYlBJS3U5TVQ4dmcyWGw1VEJNa0NqVkRycEcyU2FDRTB6blli?=
 =?utf-8?B?cjBOVW1QVWN1S3JkQjRsWEZCc3YrZ0hPYnVIL3lSSTlnOEZ2Y0RMTUNBVXhk?=
 =?utf-8?B?aDJwamFmaW5oNk12bUZLREV5OVM0bFF0eHIzdk10d01RTDIrdjVKaXZBWlVm?=
 =?utf-8?B?d1dURnRNRzhhKzhPeTYreExYenNOT283RStibDJHS3VQUExZNjgvbHJQd0xN?=
 =?utf-8?B?cXhRVXQ5S0l1YWJOcjJWeEJpTUlEaU1LZ04vRmxtTThNUU9nZURSaW5UYUYy?=
 =?utf-8?B?Y01QMUQyZzVxYUFpcjhLL0trYmF2TFFGZ0hnazRiYTNhNHZoMnEwNU1SdzZj?=
 =?utf-8?B?TW8rZlBiUlZiVkpkVU9BcDFwSU9Pd3krV2R5RlYyTTM4cHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS9CT3BPTGV1MzdETVlQMU5xMEQrY054VDRkenlSb1BQcTNETDhVQXFRQVlV?=
 =?utf-8?B?Q05jZmIrQ0Z3bVhXNWZsZGJzUi9tSWVaMkF3TnhpeTRsc1lqMEZrSXpyQ1lB?=
 =?utf-8?B?UVBMOUVKUjBpMy9EWDJMZHc3VEV0Ni9NNUhuMFdOYmJJNjg0aEtQd21lWGpX?=
 =?utf-8?B?Lyt6dDNIUENEQ29VSk1TemorcjlDd3RQRXg3VVVTRlFLVkpyVUNQNk8vQ1FS?=
 =?utf-8?B?TFZwclRHVk9PYlBvY29ZU2JHY0g4T1FBOW8zaTM2aHhzVGNHOHh5OHB6eTlQ?=
 =?utf-8?B?cjhEVFBvaDFRQjZGeldrZ2t6UU1PM2V2UU5lNlZBaklwaTBvNG5EN3gzVUxB?=
 =?utf-8?B?Y3BESGFuaFhicTBxMDNOUXpHYmNLOXozbFpINFRqellmV3RHaTZGT1MxNXFZ?=
 =?utf-8?B?aHZCNmdYdG5idlQ1Y0UxQ2l1UWJWMjVxUjE1MTlmLzVNaDI3eXl1SEZjcTRi?=
 =?utf-8?B?dnFMTE9pNDNxVHpHby9sYmtpNVFqdVlSMHRVYUo3MXQ5RDJlenZ3Ky92bWdW?=
 =?utf-8?B?V1I5WmtiMlJ2cU43YTFZS1JDeFZVUVI3eUprYldKbURaRmpQK0RmM1pPR2s0?=
 =?utf-8?B?ZWZranQ1VVBZOHlSSkZOSzc5elA4bXB2K21JTGdmL2g0UzUrL214MGw1d20w?=
 =?utf-8?B?MURETFQ3RGVTUUdZMERkMHlaNFpmNjJGRjMvbGFFc0l0SVBKbUZ1QVFqZ3pG?=
 =?utf-8?B?dThmYWVGTWdWc3djeG12MUJnTVp5MnNQbm8yRmJRS0Q0S25JL21ETDExUnl5?=
 =?utf-8?B?Szc2NHVSVDBHa0cwNjVaalp3dTlGQitUZnBCeG1IZ0FvUkFFajFQcnZUWC9k?=
 =?utf-8?B?UVplTGdoUFdLYlF4d3E5VnpGMGhnRzJCNzJvUGpqYTVEa2hpUTV2Wjc0cmMr?=
 =?utf-8?B?SVZ0NDZPbndIM1hwdzM1b0xsK21EWW5IVWM0ZkZQY3RMM20zdEpHZE5FWkEv?=
 =?utf-8?B?cDltQWp0bFMrQzYrWjd5YWlBSUUzNlk5TnlSRXdBZ3I4TmQ3WFZRNUI1c0RY?=
 =?utf-8?B?eVZNQVc5UzR0UU8yWVFYWVowVlRXS1ZkN3piWU5JVlI3RjNqKzcyWkhlblpH?=
 =?utf-8?B?ZmVVZSt4akRuMUo1Wnh5dFhZbmdsdG9Hamlma3J6aWppU1p2MUdueEtmcjVv?=
 =?utf-8?B?MG51bnlUZmVBLzNTR1R0UkVPeXlDaWRtajNKWTZuYUdxeWkwTk1xUmhmMGo1?=
 =?utf-8?B?V0pCVGFsclpwdittQVg2RDViTmxKZTZwUks1TGdFdU8zekt3alI2RTdrM0w1?=
 =?utf-8?B?MSthODBXS0tLSG9vZkhiTUJmNzIwb0VPNWpPQ0ZOSFlDRDNFM00xZWdrK1Vh?=
 =?utf-8?B?cVFRL3VYNjlFNE43eUp1bkFYcE0rQVltNHBxckQ1ejNnVmtNWFFaQUt4Nzc3?=
 =?utf-8?B?Y1NFSTY2V3UxWWJGYmtKRW5SYlV6cms4TFBBSEUwNTNyOU5hK0xTaDVIUmhG?=
 =?utf-8?B?R1doQ2tBeVo1MzE3U0FWbVUrK00wL1Ricm1uWVp2NTkrdlR2Q0FBQ05QR1M5?=
 =?utf-8?B?OFpoUWIvRFJGcFdHaWNuTmxEdUpDdDd5VkYrcngyOXJSMHdITnFGWjB2Q0tC?=
 =?utf-8?B?Y0V2dVl1SUxEWUpTelRtUXg1alBhZ3hTYUZnSGV4d1hkcjBTWUZ6cFQzR2Q5?=
 =?utf-8?B?dTBld0plZHVKSnorVUtQT3lLclM2R0R2ZG5sVmp1MmtvMTdIRGdlekpHQ0pO?=
 =?utf-8?B?TmJwYkVaVExCWnJneE5mOFhHT2RiNlM1N1YvUVRrZThVOFp5VWcyd2ZZQ3ha?=
 =?utf-8?B?THpGMERCbjladXBZaDJNYURqVlpOaUlrbGJzTjJoTll1SmxxTzRBWnpyL1Rq?=
 =?utf-8?B?L2svdWZCM2VKVXlFTlVId0pmTmoyZUl2cDNxT0NCOGE4L3d1R0lYcDJGOHFn?=
 =?utf-8?B?bVA5ZS9Bblo3R1pQdWNGMlZoNDdkOEtUbHRTZ2wvSVhwRkhMNnMvbmxUTkY1?=
 =?utf-8?B?NGx3RmNicWRmRVIreTUzZWg0Vjl6L1ZCMTNrYWJlSzdLRHJPQkk0Q1VBbGdk?=
 =?utf-8?B?Q0JsUzFNVGZCSmhtV0Z2N2l4d2JBc1ZLTzhDMklQQmZDZVQxNFFNL2sxSTZT?=
 =?utf-8?B?L0dEWEg1cTNYZ0pTbDFTK1crY3B1RDlGakJKWjlJaU9qanpUR0hVMlZML0Zv?=
 =?utf-8?B?VDlUazBlTjdFZXNKbEQ0K2FlYy92U1dkMXVheFlEajJmTldtMVNOZW1QTzdn?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FS5hdDSF7jj9nyUzlg4kZJAiTwGFTOMSh6QObX7V2mMM8KcsPr6ebu+2MRWf8GMfBx0o+csStekrJh477FHI6QKItKWvDnuK1V0hQXVhE5GgQwgHMd6QK0BpA8OhXSZzSnkVfj/xfHrjuKHm10CajSXS7u/EaBOVc/A+UJTbRKTxI0SkE/gjMDU9HBbW/+yd8MG20PMHdoSu+YeshYJSOrQeD8j+spjwiOGzxSj7F10LtKfmXlp6FNIYItqaDHu1n0atVuui3y0IIZHLOlZaKZj7DRt9WBTZLE5euHpeg9IBfUQ5Fxi0OBmx0+dWg1kwobzuVYjSJ5lV+E+W2/u2/vPoJpyUfIHC0DlGZjwS1PbxrNnsoR8hY+PEafJLyRcQbzrnY+FBQ0yL+32Tk6H7xvxSNqwtnHTw5Od/q6ECHin4LbsDugwGkKXcSWIk7YunJNtCFmM/YOiLin/r+BY803hZhLOGb1WGBwY9SQ27xZSyWbUkzyncp/oH0JMilN1IT3xTsKMWNPgxFaJ+k7MSlq0aPo8WCBioppyxqdaMCoS1noGHLRlnUibk1YjXw2lz44//LDFTnFiMN/7SjpOIcgXZ0EOTlGzon3a11DW7Boc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ef2b96-6944-42e9-569c-08dda840fd7e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 17:05:24.2737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUO9jsadFbv4j7dzJhC1kQKYRGxQ5Jx8DwwNntsduojqxwFtF9DY0yk4Xky0MTrQLCIfMrT5WJXK/ij1B97IK/dsV/Xtkw9JY9KKqoSB468=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100138
X-Proofpoint-GUID: jnqv4n8exW0OUxQjG_PGYlf2Xt7hl-YO
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684865d8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Pf-Sc11COkOkbg4jDJMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jnqv4n8exW0OUxQjG_PGYlf2Xt7hl-YO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzOCBTYWx0ZWRfXxstlmJvTTSi9
 /TJYSnwZa+Ys/uEJmUUFuIzVbCvEaDTVoJrs2s5LVsc0Fo23l+Xzb3gXAhOTFTace2jALVnBATn
 +Mp8bdSWfGpSmeVZ/XC6x1qlQ3DuNKG0w00J5GN67300vFmxvIMCGrCRXOrPehMe+5xgJoQNisj
 Ja1Ps2CRFsBm5Zyc+ERyGetBnCsQq+cTcFbtVxYlprM39nVCZwrCRuz0TKhGYoXr7bwLv9yRklk
 oyujX1I7G+MhttJ0boHc/8nkFe8tRUgMBSwcUCwv4646Zh7Jt0A+jZosB/7YGo2qdNIid3zwrkD
 gAlUG3dO/zTzmt+6b1RvCZXLEiUCFZGun3EIhw6CMF1AaZatnDeB9kiwbfd38/k1u+p4gpXJ27g
 yH8cD8Um+Q58kCD0hha6immkBr2eBo80aQyRokoZbzt2rOh2xJcZcgrimaw+8LPmaqgEtkNW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/10/2025 12:31 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 04, 2025 at 03:48:40PM +0200, Cédric Le Goater wrote:
>>> I don't see any advantage to making this a class attribute.  I looked for examples
>>> of using such attributes for vfio to configure pci, and found very little.  It
>>> sounds like overkill since vfio already sets and gets PCIDevice members directly
>>> in many places.
>>>
>>> I defined skip_reset_on_cpr based on this existing example:
>>>
>>> vfio_instance_init()
>>>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS
>>
>> pci_dev->cap_present can be modified at realize time. skip_reset_on_cpr
>> is a constant, for which a class attribute are more appropriate.
>> This is minor.
>>
>> Michael,
>>
>>    Are you ok with the 'skip_reset_on_cpr' bool ?
> 
> Generally yes, but maybe cap_present bit is even cleaner?
> vfio already pokes at it, and we have history of encoding
> quirks there, see QEMU_PCIE_LNKSTA_DLLLA_BITNR for example.

Sure, I can send a new version based on a cap_present bit QEMU_PCI_SKIP_RESET_ON_CPR.

- Steve

