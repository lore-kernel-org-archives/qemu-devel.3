Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1B606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=yI1e3nVp;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=ZVGy47j2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGlz-0001TQ-Eh; Fri, 23 Oct 2026 11:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl3-0000Fw-Vo
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xKGl1-0002eV-Li
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:00:37 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6aFO3758148
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=trd49vLSXYIOuUa1baSl+Rcq4h1F1EIbBXvyf9JQg
 hE=; b=yI1e3nVpBTiWzqMaNuw+G5I0jhDF6X3Kgd10co7OSRSpWOy2p0+2XZ5Kb
 DRxHOc15NEpXDjUYGHtjs2kwCEgL7N+wj/yjWx6Cv526BbOiiLZKnBfeX5lG/X6s
 DVVeGakRzAbjO2Ua3+h3Af5g3lxosdAjzQEYpfDyIo9mG9bFfFoB6WTn/Usuhhl9
 /KA1uP+vaCc0NQqNm41Gr2uXhnyR+1NmBgjZX3kLWZ/Opab0F5Ep2JNBfozST2B1
 R80eKYIW6aVm4puLNFFuRFsgyAerMIZQB3yCYvDtuoEuSrpD9aaLy21tGA60Sjvd
 fNWzIyNKwg160qM5ZZWmlEoyjBhRA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022110.outbound.protection.outlook.com
 [40.93.195.110])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hf975d00w-4
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0lCmPr3ma4NYoYaEpMLfwE/VEwj3ijBCQI+7RNubhd7f9RBDBkEB4WgNDccPEi8xuy2Arr4a2QHooEAP1H3STXOm6ksQ2YaeTSukG3yTt0SbiglbnirB9l6yVIJxopD8mG0h1/JvWqM/ghnIC2NESPbUTWas5MkfXK42Iw2QHyP7tOqcjyRHI0D9cwdAiiMX9Foe8/ZHey+zPjbn/z/7Gt6Y08/3qk/63sZ/SjRZyjxQcqjUEh6fsomCg4dZvaXt8MLDGnnfhm5bKrrCnat3ZTqdhtuWT0bJ5QSjkcp3VtlyeR37CYOg7mRVRJBUnwLvYPGuoKenFgFeM9p47BKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trd49vLSXYIOuUa1baSl+Rcq4h1F1EIbBXvyf9JQghE=;
 b=XlJpnSj6TMc5jXaHdrWDQht/by30xBS4V0YkT29drk6mp9cWsKX4wz/Rn/dCSIw0NwuyrWOr4iYZR686vsCC91L9Wt48OSVFnnBAxbmSB/elatwmnW6dMemwo0LhjrNrcBdJG9IxOcp3+NxvVSlJ7/flh+k59qs6sNthzzkpx0xN0vyHzP1/9RrQPW+gMeSHWZOFTssuLONHRSJYtYaBfko0Dh9Vr0DRViR3qAkvqSNRmbQBtMJnXPbAD+6EsXqThHyqTsMjk6qBu472o1FRWNQZNsk1YqbHaiI5uB4NxA3fiFGaD7WE5hY7m1E70XPpFD+62kgrJYMjAMhK4wJHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trd49vLSXYIOuUa1baSl+Rcq4h1F1EIbBXvyf9JQghE=;
 b=ZVGy47j21n4mX4VrcCBBo2kksrkWFUyQ2OKnoln/pSji8SQvSRiF+y6c6nCih8i9lhbAtG01yXiY/R8vOLixxWMV7duSv04G/ra3Ibgp9XoWQEBiiT3OdTi99tr9OLVTl9O3XNBn41A2rUYluSUxCijcup0x+xgN5cg6tBNc5XIzbxEqay2Hmc2WLkyQAMbV+JVURajUFRctuAuxoBhWEZAgJqke8Pbsjwi0fp6Q0hoQSn5UWG+RM9bqXAJRK1kZkA5A1bNsNPMSiXucqpRyGIlGTXaZYl5r7F67EpUp8ZjZWZjQhv+XDUvg391nmej+VRzqR9RV9WX9sS35I89alQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6669.namprd02.prod.outlook.com (2603:10b6:208:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:00:20 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:00:20 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/28] i8259_common.c: remove unused i8259_init_chip() function
Date: Fri, 23 Oct 2026 15:58:30 +0100
Message-ID: <20261023145839.34909-25-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023145839.34909-1-mark.caveayland@nutanix.com>
References: <20261023145839.34909-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c62083-c5cd-4c3b-00bf-08df31165b5f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|261021123027099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6hNcCDuZuUjoyelbh4X/cKIE5ocELuvg2xNPA1ll8x1naf8zyCuzKCJzJWPa2ach6Gk/MLQTPKNhVFvSvxMIUlLHeukBxk/FgR3sauvFYeDEoOqJqNEIQxe6+BeYolz9p86jK7vtcnpUlN8XcmM+Y8r1LI2pgs9deMsPm/7EjjBte4bGGhZOy/iObKJXQywpXi0Revrw4BpZgMH9Z3ySLVnEs17WE7lJxMUn2U5kAQW1GSx1IkOq+YbGk113x7UChvK8/sWsWa1VcI0O61CPlqtuTtpGOPq6XoTc3/bzzlBMZ7WD6JSmj+e/bTJgOtA+ycN150x5GUf6ao5KMVjDJUHcdF+jmgy2jDADk0jJPsqkeTgbDniumU3yQ5lg/LCD9xl4XIwuf95RpppaC9qkrWVVqD2b77Xaucj8ME5l9jNDgdEmAyoedaZUzfmDNCGtPasEviJo+NM3P1OB1WyFE9ES3kHNng1gfFnVAlFRWFG3g8GfpHCIY7WE9e04mQP1E+i+Dg8XJNvyKdV2rQAxWEutIWuAN6lmoDH3R1T2mAmvDp1gzS04TA3mf4GqNtBOOOvSQUOBqelaPG8QF/VtxGCkFDB//hHpZmL5VMaUHONrb4lAl3KZTi/c1SLfVWs6UYRiJDenHfIiY9FuvKcCw1Zlxk7JrLa3cXu+vZ9W/NM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261021123027099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?okM839/wRnEgQpbZ9Ij4+CDUUyzdUJD7cO7odFImHlDSUXOzIzGa8IjAncKY?=
 =?us-ascii?Q?dI8q/z6KJTSNbZqsXMkfNPBSRjY2VxJg+cEABTLohbxWCmRysV9buCVmFkEb?=
 =?us-ascii?Q?yBgzi9Cw8/RWbOzk1W51VvqwzfdaLoplHSQw/EkzNoBM40cR2Iqtc6OdwPNM?=
 =?us-ascii?Q?k1LEtvybyU5fX/dm0cewDXNcJdb0B80o67vQQIIfic6rLEgzI+V1VDX2VWQ8?=
 =?us-ascii?Q?UPz3R6Epivgy4KZCw9r9iAmFIkXtLP7dO68HWsaesm4Ki67MhuGpskDsdfDT?=
 =?us-ascii?Q?gdliAFcB1H9e3QI6p0aRdD84pK5xkfkuHqt70LujZAPYadBZS4hNrUdfVHMn?=
 =?us-ascii?Q?2VPhfFN5gg8QXMKCMQqCKnI2GA6Phndac30sFSd5hK5zXLS2T7FhnDoku57V?=
 =?us-ascii?Q?xWbW1PktCHmpVY1zJIJ44w6e2hnV9Jt5eh5xNOlIkd2RlZ/0SihKy5Dh00ja?=
 =?us-ascii?Q?Gb5BtBSrOY7ktwJtrn8s6NqhfryZ7BOVy2pJR987ufF2tk5yagn3f2Xir2or?=
 =?us-ascii?Q?nn1Bp0KDyLtbZZReivVLtLFTXNH9zEu/1wz5jCv/8joRicsCVWMV3Ycf7JrB?=
 =?us-ascii?Q?zBLBNAGMK0j8030V3r1SsFofsLydGJNKAYbGkHuu59bCnbbALJvCN5qLqnjs?=
 =?us-ascii?Q?a++UdyvERCJQNYSBXpZvUqYV/buOL+aa2bIitaRr9Nwlj87/48fYHQBgq9h3?=
 =?us-ascii?Q?PUNJ8L27O/WklT8v/DogOrJ/uOyPXG2vNz/70O0lvZxwOtNYxFMGIy6rqQyZ?=
 =?us-ascii?Q?KBug2O0lB6YJEPBrnKv7v+4nkT1eOa5PYrE+Md/BeUcvlZ+7ch4d1YxUvoc/?=
 =?us-ascii?Q?9+joL+EraToZ8IMZ5REuuCDzfQXWSZMZIOHZiYfmwqkTzCAQOVVntagxPupz?=
 =?us-ascii?Q?r1lpHUBfPLUbll/Lqu07u/NsVqdqCrGgxeQkiT6b3wSWD1oAtyP3bM5nfr/x?=
 =?us-ascii?Q?Pi9b7CIAj0R0DMWeoVrKmXeoWMVcm/iC0NX671eKhbqU5Hxtvve6/ILmfYYk?=
 =?us-ascii?Q?yEzzil5hYteZnRODuQmiu2Mtkmc1TGa5t6pfoFHro0K66hbZiiOCKwjvnxLt?=
 =?us-ascii?Q?CBRdUc1PcVTrk+46XohB2fW3D3KApvn8zZtX9olcGiJyaQfoHIyZod0YRMvd?=
 =?us-ascii?Q?2untPdmaRv959cKN+onggA4zy3Of+76rk5uU+6JQ5bVtJsHH49i6mOWN9nJo?=
 =?us-ascii?Q?/J5W9Zvrw1ixNhQLWVQKjJGzGnlm318JtPRUIViQuxbVKnBxWZQlQpUAK1+v?=
 =?us-ascii?Q?7ZxfeE4n9tRcKdpUsW0QmBrx2DJCXRFpp47nuM0A2BtrgAYSJCOhlXY3ZdBo?=
 =?us-ascii?Q?0nBZtD5/NH2kNXarNp/oRHmrMnE/kTGiiJiadCzgxMEIEa8odc1dSJXk8GnD?=
 =?us-ascii?Q?QptfYUuojLjbKwghIZqjXBA3k8GWAoxVKrsTteAGJxWqOcAJVXZWhgHmv+Nn?=
 =?us-ascii?Q?YBv7mRvVILLvMjHG+jYz4BKsxfstasKNebdxZ7OrPGvmHr+5ueWK6IMbgrH3?=
 =?us-ascii?Q?IiBLpZXde4n/grGJsKrqG/TkPj1K0arGR16uQR0JYVFSqaFybhVf43nai08p?=
 =?us-ascii?Q?vIlS+C9ETNFSuMZhNDTreXwpG0RG/u7L/D7r2veoZYqnI4/kWTa36rIPFA2S?=
 =?us-ascii?Q?gMbmH4swuzP45rAQlDYJ7b2nnkrdZ9nbmYF716Zv0N5jPyMP2vc3Y+bXqWPO?=
 =?us-ascii?Q?ADN6U163XHYmYMBfebHjnKgLW54TPNCAlvHjUTF/xEM95c6EXFuGECf3SCd7?=
 =?us-ascii?Q?8nekOmCskmY8S4WEXLSTK5kI3QsQcWs=3D?=
X-Exchange-RoutingPolicyChecked: u4x/YrzOuISUAa7iEaPuNeWNmcvEa/G/a4SWNp7f2TC58PubMGTft16Y9s3HCja6c2oh1xay6a7Pd2sCzvAmHYQUGUFeGnmSMKogfp07IF5qPQnExKj5l5oUj/kzzTny3UtxhKcNA0rQaAs9XnMkJB6R8a5cgZVAY0cRHhd0VKqqKJOoNVFTxrvjShbc/JsGtli6X6atTvAcEfWsAolvIOkls03+jkl/84ujrPbw+dJ9DGOotZeeNw85gUkg52IkHduTKsuKs8hpw6GKIgAkkJk+AAmpzyitbAPqz/+Y9Qk/v8uU8qdR1yPRX6ESEJwDhN3QINsp9b3sgoavJsqIHw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c62083-c5cd-4c3b-00bf-08df31165b5f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:00:20.5774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5z7H4yoabo6D3kKKjHNGFFoyj8mPZgXDpNaObQOUlDgK2eMCprC6HZxa/440Q6hjTfRJV3/EtaxfwwcFKRU8X8/UDtfjmqU2YupGbPSUIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6669
X-Authority-Analysis: v=2.4 cv=TKLQ2Fla c=1 sm=1 tr=0 ts=6adb7688 cx=c_pps
 a=Z51Wl0xbhtNzWEVEbRWhig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=fn9E0C1quIHmE1dKZfwA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfXy/vUU4P6faes
 Joix4YBdyHpdF3nW77TRLBasWH2ORfHpughYwACBtcSonrGhhupjG8J93LgrMXoCcGJTJdHZCX3
 DBxeLkK2GwVMiMf7vBa9lEGkx3GAPh9fjSwtW60I/z389xvqcNbV1P0K97fqZr468jeumZdW/N2
 3J63gF8nmAoScyD99VMDw3vvberfq/ejP13QOy2IFYw9CLF5L7Njmn42ZCZ/SZocW00CrSOs/Rf
 ZICH9T0eI1nZiVX5bacEY/hF4D2yNg666bBZT5kzCiANl4N6t8jS4PTRHpNYq3WNmCUcutCADtY
 S+f2fY24YzUJSXgOHaK28urO10J2NbOK1EWmp16JyBgcYlAP7V26Z5PEs0VMSQRc7Wo6x9l2ZIb
 TMMRaLcyUdWOGhSdAF6ofmTC90+YBJpKsrLGGLg9ks3VgKJlR/NCS5TWos0+1nV//beKDbyy3JS
 DPXAFlEhJV29BHhJ9wA==
X-Proofpoint-GUID: IKRfqMgfNU1T05YiXoc8WOjyh5SChrLf
X-Proofpoint-ORIG-GUID: IKRfqMgfNU1T05YiXoc8WOjyh5SChrLf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OCBTYWx0ZWRfX+Eq1GuMEUsC6
 tJx3rf7H/6mii9kSlIfCCfJe3ow422jGqCCPK1Phlc0+KpQoZ0VC85AZ3UNCbCcd9+mNiXiiR3U
 XNmuduPe7yXMBroeLFwhnYhUTGxRkeA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This function is now unused and can be removed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261019120517.1448687-25-mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  1 -
 hw/intc/i8259_common.c          | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 644508a44e..dd255fac24 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -71,7 +71,6 @@ struct I8259CommonState {
 };
 
 void i8259_common_reset(I8259CommonState *cs);
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
 void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 09b761321a..5fa38fbc5f 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -89,22 +89,6 @@ static void i8259_common_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, cs->iobase, 1);
 }
 
-ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
-{
-    DeviceState *dev;
-    ISADevice *isadev;
-
-    isadev = isa_new(name);
-    dev = DEVICE(isadev);
-    qdev_prop_set_uint32(dev, "iobase", master ? 0x20 : 0xa0);
-    qdev_prop_set_uint32(dev, "elcr_addr", master ? 0x4d0 : 0x4d1);
-    qdev_prop_set_uint8(dev, "elcr_mask", master ? 0xf8 : 0xde);
-    qdev_prop_set_bit(dev, "master", master);
-    isa_realize_and_unref(isadev, bus, &error_fatal);
-
-    return isadev;
-}
-
 void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
-- 
2.43.0


