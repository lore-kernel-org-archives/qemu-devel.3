Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD9AC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 20:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK185-0004qk-JW; Tue, 27 May 2025 16:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uK183-0004qX-Ja
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:42:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uK181-0005hp-8V
 for qemu-devel@nongnu.org; Tue, 27 May 2025 16:42:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RJXuap014501;
 Tue, 27 May 2025 20:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=krzFauvihPRO2pJ6ya9xra5FZLJKLHR8vaiAMTDiMT8=; b=
 JrvmzeFeR7ic2OVBmTfp7tm4Hd9i9jPTkeALMGmstGB8lukmy6aN3BT2A27aMBUM
 fo6zzTBv6OH9QcNSIXn+QRQDsN5e8aSxagt0BQk9FzDAAreVZyCumqviPF0NHaxD
 Vg3IqDuVYYTMVuf+Df4axVvh74iwByw4ZY/Ly2kGhikYpQHi+PqL4VVJsD7Onnx0
 Ok6DmR8v1eTX48jr6yOGwGzRjtwrmXx4wPKhJuErfByAPt7cCBpeW6hRjVamOv0l
 wKS18HlulgXX7ejzGZrkWVa732uQ427CJdMxLMBPugTd88ijTxZ2dlS4oyJugx+a
 1rhYjDd1SrbTOJYFV5x3zA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v2pev8rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 20:42:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54RJgWPU028522; Tue, 27 May 2025 20:42:21 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4j9hjvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 20:42:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pal5VK5oOqw1PYhjyPLSANZ16tJNAUNZFH2mZh9GqtB2Z0txHtP7YaUn3rQ5i8tlNQNzkqV1WUpgFHd4gEMcx3C061KyAqJdxWlRiAK25dUH+eFrKQCR5NjpbkJLJqbfJx8X3qVXTt1/tDrMmmnrjyymYk2Us8UhPDcbZYkZ+jCBtTQ3w3RfWdFvPexSPHb66GarZkNxtK9GrKFSCDnPD6n7cW9AF7Cy0EkOWzyy7JiGsrKlykilRrNP8DoqPbD1IZPojZ9oEvOx73H5+MG/315VVvy3I6It2cqjhJ6vS6DxwY4SBNRfRTnY+NOSs1KvnrFvqlLPOgalSIhjh7qTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krzFauvihPRO2pJ6ya9xra5FZLJKLHR8vaiAMTDiMT8=;
 b=Lmd1OBbwvtN3Sh9K3b9+E8Mzk+qtkzKWXkQCkvwHo6ldfcpB0xdHNm/yxj+K/EWMlvrrpNSd4fpPURMEBHCxUaetfh0Q1o0PXdw0RKnCvPBZs5h6lMeeOrxb0olJTJbmQ255cHCvLcLQD/5M5djhhCFW64NluhDcOefcPBSrdTshZiLo65PeaoerV6dfJBrLz3VQkNMq6twRquuYJ27cRSFFGdHU96VvQqWppDZ1pbG0DDuO6FFVyc5TEPedEDJxXXG55h0QaDuS6cljSZzexflx54sA0q3so/36m4RRrGPbZ4TdHn4rruFtBtA0JQvpD5w9fQrC2RLBlpwki/sV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krzFauvihPRO2pJ6ya9xra5FZLJKLHR8vaiAMTDiMT8=;
 b=izOYw6FDZbB1iwtYQcx+fuxEddHoa42Lo84zBndajwgNsrydG7a7lJfUc95FK2I+IY9Z2ggzHqDsKeS7e8QDgm6NvPEnKCpuE/gj0GQdVj4+rN96pOz9mfFCFadDhvwQmjGeV2mNmHDwaZfzAJbQ18B0t+bhG8Otw/17dOGJP1o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB7770.namprd10.prod.outlook.com (2603:10b6:408:1bb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 27 May
 2025 20:42:18 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Tue, 27 May 2025
 20:42:18 +0000
Message-ID: <061a43b2-b96e-4d32-9e81-f5d50824fb12@oracle.com>
Date: Tue, 27 May 2025 16:42:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 14/42] pci: skip reset during cpr
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
 <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
 <20250524053413-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250524053413-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 491bc095-f8f9-454c-9456-08dd9d5ef8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEx4RnlZRXJZUzhyaVlxMDJSL2pjS2R4Zkh3b0FQQTZKVFRkdlFkVUdNaUNK?=
 =?utf-8?B?cHREQi9BWU1tZG1LWWc0YWJMRXpiNlQrZnBiUkE0S2laVHpQbFdwWUhvWVp6?=
 =?utf-8?B?R2t1UmpuTjd1SGhvMHVrb0Q4T1RKNGJFYlBheE9hcnZNL1pTYll1RE9xeFNz?=
 =?utf-8?B?aXVERmQ0ZWRwcy9HYy8yWEhKR05xMWRybDdoV0d2S05qenllZ291R3h3N0lH?=
 =?utf-8?B?MTB1MFY2RldoTjAwQXV6TmsxL2NDSDVNUXdhTTNrczBMc1NIQmdSTE51eGxu?=
 =?utf-8?B?UEsyT1hQT2VqQ2hwRXNIK3V1MmdNQ1liMVBISm1HTUI1VlZMMWl6OVBMRG9n?=
 =?utf-8?B?SExnSUxGUDJuQWVTRStXUWduTHF2dzRTb0QxMm1Yc242cHZjSGYyZzBta3RV?=
 =?utf-8?B?MFNjY053eXp3VzE3blZFWDJaQW5kYXRMS2xoOGVvS2s3YW04RzlFbEV2UkF1?=
 =?utf-8?B?d3FNZUdvQzZFK1VRYUkrUjhMcFo0YnBYeEV2aDRZZ0NyclVLRHNvVFB0am13?=
 =?utf-8?B?TE5BeHoyK0pDT1lhVHJaM3BRNy9hMExLZkVib3B2NGhmc2x2MEZwYjlNL2I4?=
 =?utf-8?B?L0FQOGFuRThFeGxxREw1dDhCZUwyUHdrbUFjSEJ6TFAwQ29wbElaclFHMGNX?=
 =?utf-8?B?TFVzWWtCU1JXWm80K096SWlxM2hLS0ZpcjAxQ1QxWU1CczVRbU1tbENhcHBD?=
 =?utf-8?B?MVpqMkl6T05VQnQyQUFsN3hjbVZjQ000TVVsTTFpS2V5eFR4RmpRRjhLa3Rz?=
 =?utf-8?B?eERndjRzcHpmMzNtekptMW5vYVd2TmtLZThjbjFoT3J4d1pvNVR3ZzZ2blRh?=
 =?utf-8?B?bUZDOWFqQkczd3FKV1BKa0xxeWI2cWdzRXpVakwvUGM1S0VrakRPWEZ3ZXZz?=
 =?utf-8?B?ZjVBcDdUSWlRZDhMUkh1NmlhV1lwYllsNmMxeTFvc3ZjWXJRS2lJTHFCRUpC?=
 =?utf-8?B?dnJYdG45RlJNSDlnL3diRlhjZG0zMlVTalNYYmRDZE81eXltT2FPK083Nzd6?=
 =?utf-8?B?RGdnSWdRNy9jS3RuNlVqd1UxdWRycFMremt0TGw5SDlnelE5UW9vZHpQYkUr?=
 =?utf-8?B?REJudWo0MHZTc0pOYTRwcXlNZ2FJS2xpYVVFSUNDcXBFMmszd21sUlNQMWxS?=
 =?utf-8?B?N2ttcU9tcVZVT01VdFdBcER0MUpreUN4NGtRQmdlZktpazFrTmpZbUlXZ0lM?=
 =?utf-8?B?eXRTeXIwUkpzWFl6NmtLM21ZblQxUkRFZzM4WWNyOHpzU2NkeEVDbEdYazl0?=
 =?utf-8?B?eHRjaWJ6RWV0V29hbUYrVWRBekh1eklvdERlNXNseG42b1drZ2IwdHdrVUd4?=
 =?utf-8?B?MlpNREsrRWhrNmtaaW1hWUtlVlVQTVBRcC82bkpFMG5tWW1iZXBaR2xJVk1h?=
 =?utf-8?B?NXdQZ0dEZ1kzSWEvS2FncU1hM1hienNZTUtJczNXNTdiNzY2ZEhQY2dndnJy?=
 =?utf-8?B?cWVHTnI2SUh3d3VLUDNPcWd6WG1VSXJnOXBJWmdobzNPN2ZoY0hzaXVIa2RS?=
 =?utf-8?B?aGpnMmFTN0JzaFBrUXFXeFlrdDdwUWhvbmRqdDlFMnJIaUJ0djJlU1RudWpQ?=
 =?utf-8?B?amZhTndpM20vSGNIMVhNWGZVK2czaUN0TzA0MC94UCtIb0tZQitnakFZSEpu?=
 =?utf-8?B?c01mbnBaZ3RUb1FTT00zRnlZa1lWNE1VMkxUWWJYNlExcWszSGJtQmhmWUh0?=
 =?utf-8?B?T01FV3NqVFpMZEc5emd0bXdlKysybWRtQlM2cG44dTJBRnhGdEVEeFplaUpv?=
 =?utf-8?B?VUc2ajlMYStWakhML21WUXY3azR3cWFqSmlPM2VmQmRvUFJTbkhmbWU4MGxY?=
 =?utf-8?B?SnRmNzdGOHM4S2NxU25Jcml0Z1V3cFZRTEVkc3haeU85WHNWdE14VTVFb0hE?=
 =?utf-8?B?TElFbU9FV1lmU0JRRnpTRi9ub0VRMEZCL1djT2hpQ1BlVzMwN2Z3Ry8rMzZr?=
 =?utf-8?Q?Nai+TRvNA/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklpcGd5RmhBY2dHbTd0N0k2djVCbk9nemdYK3FxNFB1THcxQzhLbTJPaGRZ?=
 =?utf-8?B?VWFGOTV1QzIvYmx0L0VGNU41ZVJIdnlsVytkTStYclZHZ1JaSGVhN2tyakRZ?=
 =?utf-8?B?Sk1zR2VoeXlwaEFNOW83ZUxWWmRTMnhZWFEyVGtvQjI0SEIxNFZ3MTV6eTFC?=
 =?utf-8?B?M21Ybno0WlBWTG5DVUJUcWo2a2daUTZMSDc4a2ZQL2Z3QzhvTHhMZWYzWTYv?=
 =?utf-8?B?d21xZHZDZ2gyNFpZaThpUnozYnM3UStzbTFaSm5jOCtwWG0ybUdyOXBBSXk3?=
 =?utf-8?B?ZTB2NXZrS3k3TlZhaWVnTkJmSmx5dkw3T0V3OGN4a2FscVlTTFBXS1pNMXUz?=
 =?utf-8?B?VW5UQm4vdlUvQnVwNHArbU1tM2tleDcvR3dvdC9vQkwxU0xZeGo3WXgrZDRS?=
 =?utf-8?B?VWlKZmhqTG92blo5TEluYW55cWJHVENjbHgrODlkL3d3YU45M1VZSW53MFI3?=
 =?utf-8?B?cjBCem9sV1g3Sk1nK1lKbGNFNTVXeVA2ZDlOVER2WGJBK2dXTlNmWEcrNzFL?=
 =?utf-8?B?OG1kVDlKM0tXK2hCbERQUTVURzJYWnNvTHg4aVpOS2ZkYnVmcXZRdnl4TzEv?=
 =?utf-8?B?K2RYUzlYY2hSb1pHakZWdFF1ZkRKakFUUjVTUzdRWmc1V3J1NDNWd3BWdnY3?=
 =?utf-8?B?QUpLenpZWmR4UDRndHVSZGhHTDluQ2p6Yk1VbVVzdjVEU21vcmNCaHkwT29h?=
 =?utf-8?B?djBsWTEyRjJUa05ScFBUcGRWWHJlVnQ2QjRRQytSbVZmSWlwWDdJVU1IcE5O?=
 =?utf-8?B?QVpuRWt4ZUxBZkUzQlVJUjRBR29LSXdMUXh6Y054OFJpcVdQeFJoTXBmMXQw?=
 =?utf-8?B?OXNyM3ZvODgydXMvQ1V1aVpvanVSK3pCSnRYdC9aY2hZM0tOWUM4cHJHUHkw?=
 =?utf-8?B?M0E5TXVVSVdzbGcrZExkMmtWZExuYkJac2k4cVhkV0tvTStsSWVSQlRsZkh4?=
 =?utf-8?B?WVlXNTBmaElVd04yMGFpL0NlTzJYZjd0RS8zL1JkN3NoZ2VwanZSQURYREUv?=
 =?utf-8?B?ZkliaktaWjJVNDJONXczY0hqU21LQ3QxQmFCbStyemxMTlo4OTQwME0ySjBH?=
 =?utf-8?B?VzdPT3JmQkRUK1dTU1BOVHJtN1o4TjU3eElsWmNsanBJcUphY1kzYWdobGRj?=
 =?utf-8?B?UnpJSE1CRWpsL3cvWlM2eEdabng4dU81Y0x5R2FCK1RiL2tGdnlBZmFjeDN4?=
 =?utf-8?B?STBhdllRTlBpTU1oOUVQaUhGVnQrZXFqZ0lKcU92a0dTSVVsTlRYMUoyazg3?=
 =?utf-8?B?RVUzQlJFVWxQTVZmK3JqZ2RHWG5sVEhaVng0Q3RnUERWbkwrTS9Vak9QT2k1?=
 =?utf-8?B?SHFqWXNSNjdoZmNDVE9WTW9BbERzV01uQUVmcU9qN3pnU1pRdlJ6c1VPL1I1?=
 =?utf-8?B?UjhWeGhNWllEcXQvMnhqRlpyb2hQNjE1WVBaeDVjemtDQytsdEdRSWZ1ai9z?=
 =?utf-8?B?TDdMcTNaRjZ3bnhwNkJhaGE1MVVPbkJqam5YdnZjYkk1Y2N0c01wVTBqMHBL?=
 =?utf-8?B?T0JRZ1c5bG13eUxNbEFGelNDZ2tLbXN6N016d3NBZnVwcDJtYncrWlJNdWRV?=
 =?utf-8?B?MkFJQ3ZJM0E0SEsxUnRrZG4zNERXV3dJd1Ixd3BjN05sUVFDUmVHYklLaWtz?=
 =?utf-8?B?eEtRbnZ5cGk2N2l6Q0w2bUpNNlFybVRNSkZLMGVRYUVubzhHUVdZOGpMVEJS?=
 =?utf-8?B?aE5qQWVsYTk4QWVhcnFWTWcrazhyVm1NZE5KMnRaWnMyVWM0MXgrdlo3RitL?=
 =?utf-8?B?NEhPdGtERE1MRndWNGdZb24vSUw1cnpKLzdMUWtNVWxaaGFVNkxKRnFCZjRS?=
 =?utf-8?B?L2FXSzJMZFNraUdEc29zeGtPZGdmS1grWjJzR3RVbTRldllxUnExRk1oMnUv?=
 =?utf-8?B?VUZrTnNwUkRVOHh1WW1TaGdBMm1vZHZscnFUSnlzZU14a0N4MUdZQzR2WDhM?=
 =?utf-8?B?REptVy9jd2RKL2U1aEF2VXpzc0kxL21ScWRaR0cyVVZvdkU5N1FtYXduUmJm?=
 =?utf-8?B?TVBiS0pJQjhlanZtS2NwMW5KWHV6STFBdHVZTDEvZmxUOUMvVTMwWXVqZVNx?=
 =?utf-8?B?R25ZU2NtSzU4L3pFZEErUXJjdDMzWkNsUE84ZVBEUDZBL1czYis3SjZRYktS?=
 =?utf-8?B?RmxtaFZGbVVkTWhxRXIzUGJvVGV6ZXJQL2RZbEp4SGsxWncyeHlQWUpROFBp?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1C35MSMd+gcmpoxAIaCKRfFOAIUAo+fDRPIThnR5S6DOfTAGgJAf8V58cRy8uzJMnWixaKKBUzGMfDQ34jqvmxIFSrJjwWMRlcDqdX3MrUo6M+Di7DD9heA0+ZVMMlUiS8GVQ25C9JG2Igv/uarIpzK4mkCZ598Zgw9UbWpj6Dg67lp2qITuIV7RgTRoOCUJwcbLGvz7egseKLjBR7jZE36vqnYRYAL+5t5nFfuPL4ZRErQYmeln3O/3fBNhj/egG9EZxZxNL+6XLQQrVUk0GIbn0sE4EumYTauWJ+EFZ/k2a+Mc9plx39R0Qo4N4lNkyX7HeUoLdNR+Dz3ZuEnNewgdjN/StpFFK0WfUQG5VKUQMs/4U8qfeWdYpvtyoji3ZpQQrr5Nw05LU3W2n0D3iZ+q/w2j4h8mkijMPL3izht9nvz3VW4fw9UsMZilwTcXdS4AD2Kx20YBY4GASGpfdylZdTNCXd3zUBAZattfr9swx+AiFJ613WPQYQM31LsZ6UKZOANh/tV3WPaW3UHWaQcckhBWE46aTZ/C9GL/6TKCeG+kxUrQHilet1DYmfJcSWoVrO1u3VP8qXSieQbYN9fmV/34LWQh4jqmFx2/n8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491bc095-f8f9-454c-9456-08dd9d5ef8e1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 20:42:18.6595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2bitu/ZDUTXMiK43Y+QNj9Kqob+ZEMQ6jVyBVA4Cta1/j22QjbknXrZNY4K8/xkjMgf4LfkNtap3D6oTOK+Kk9qqB3p7lWYnHQTiwTEWOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_10,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270174
X-Proofpoint-ORIG-GUID: RFatrAUAq-ZgouqiTuuIbJJb3rJ-H3HA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE3MyBTYWx0ZWRfX1GpSxe4EJJNc
 snrqn2KhmpuE84ulq0LO4ew1kqSLR0ToYH7o/opBV+KmYjih7PF2qXXb8fsoRWsg8iL2Ux/YRNs
 0uJ2h8eEreUJ/rsSqJFiGz/yurFO6j+v6l/LtJFxeCAxwfwVWs6oKR5PUTHMN1lXtv4A63wUF+S
 M1fKqE9RWc4HnJCMGyKQ5dnANsUp9c/35TOXCjnxTjg535aQ/L0y8QCls1EfPOC+Dl4XSSVoPrS
 k2Vo6hPPshBVcfD3e98z25cHg0zCMSNAuN4GjvYXUHvwuZtoqW7skPk7GoRCBhy52Ze2LQ//Mxl
 RTskPMJMhi5R6wmG8BNgkIFYIuLjzJxCGnJw1vIEeSdJDgNRZ/ByxEgeKOcU9GiJb7pWUZ993PH
 1JQRXiCqzGsjFaGIuWSOUgJO1rUOwu8ljpnBYjUc7+FygzMMuJZ20JBojBKAxqAFD0D32QXK
X-Proofpoint-GUID: RFatrAUAq-ZgouqiTuuIbJJb3rJ-H3HA
X-Authority-Analysis: v=2.4 cv=TdeWtQQh c=1 sm=1 tr=0 ts=683623ae cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=HHhUfspbjAA57z78U6oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/24/2025 5:34 AM, Michael S. Tsirkin wrote:
> On Fri, May 16, 2025 at 10:19:09AM +0200, Cédric Le Goater wrote:
>> On 5/12/25 17:32, Steve Sistare wrote:
>>> Do not reset a vfio-pci device during CPR.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>    hw/pci/pci.c | 13 +++++++++++++
>>>    1 file changed, 13 insertions(+)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index fe38c4c..2ba2e0f 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -32,6 +32,8 @@
>>>    #include "hw/pci/pci_host.h"
>>>    #include "hw/qdev-properties.h"
>>>    #include "hw/qdev-properties-system.h"
>>> +#include "migration/cpr.h"
>>> +#include "migration/misc.h"
>>>    #include "migration/qemu-file-types.h"
>>>    #include "migration/vmstate.h"
>>>    #include "net/net.h"
>>> @@ -537,6 +539,17 @@ static void pci_reset_regions(PCIDevice *dev)
>>>    static void pci_do_device_reset(PCIDevice *dev)
>>>    {
>>> +    /*
>>> +     * A PCI device that is resuming for cpr is already configured, so do
>>> +     * not reset it here when we are called from qemu_system_reset prior to
>>> +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
>>> +     * safe to skip this reset for all PCI devices, because vmstate load will
>>> +     * set all fields that would have been set here.
>>> +     */
>>> +    if (cpr_is_incoming()) {
>>
>> Why can't we use cpr_is_incoming() in vfio instead of using an heuristic
>> on saved fds?
>>
>> Thanks,
>>
>> C.
> 
> Think I agree.

OK.  I will delete the "reused" variable everywhere, and use cpr_is_incoming.

Michael, since I already use cpr_is_incoming in this pci patch, can I have
your RB or ack?

- Steve

> 
>>
>>
>>> +        return;
>>> +    }
>>> +
>>>        pci_device_deassert_intx(dev);
>>>        assert(dev->irq_state == 0);
> 


