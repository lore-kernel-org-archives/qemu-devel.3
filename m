Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE574606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=wzQYtc3i;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=VKYlAEJ4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnON-0000jO-QJ; Fri, 30 Oct 2026 10:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnO5-0000d5-QM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:23 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1xMnO1-0002dw-Ro
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:15:21 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGAK9239978; Fri, 30 Oct 2026 07:15:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zWmholqsoipVEErVDp7VBRKLB1wH8aCGQhb/fMetg
 I0=; b=wzQYtc3i+dnR9lEdbNIW6suCTk9VwuWq/pApQrP475boG0z5CbjLeoyl8
 C73BdyknLcUTVmGUigKbLZxUJC+WknmKpVn2vkArOTLqbiEx2SxNNWBbBID4q15m
 Qt9X5c4tasPp24G7FgLRumbF3aJGrFgoxEyU6F02xiwWzfWfOnFtrYvstibdo54U
 tAsdcyp4uegOAPXzo34lrAWAeoUQRjsodXlgLU9B+I9nSxGQWGq3jiMyWdYqTS2o
 xotYB2mDOSOFjqn2U6/7PtG4ivnITSRsPMVstVnKZDD2xrkXPSN74JCNdTH8YDMr
 1mb0XQiFTJbTktf4FfdJ9uKh4yvLw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021101.outbound.protection.outlook.com [40.107.208.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hmf06sqhc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 07:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D84KW/KKPdvgKCL8Uc5fkiALs9I2ugbApqmFxlXDVv+l3cSGi9MdBvjs91ieyu18YF8erdUG7OHigoz0u4Za1sSv7MZcfC65BqsvutTamK+lL3eNZEG/WhFydH4trvZxkx3xeXY9EAt/3x7iHFLeK3azwQrtoXol0ZdrYq9v2JbddYtvnUjRpT78CN0iFmifDi01mn6SnZ9SecVgTYHLOc4YCzm7KHH0ijSnCbl2F7U/502Lr6mn+pxz7Jv2qXKmiS2LNTmssSzh44IXLKq3mJVeU/i35Mluwxd8XkBGFuJ4WwfoQ/VwJmVycAiQb2Cti7nXeSTcZHPhOirkduHOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWmholqsoipVEErVDp7VBRKLB1wH8aCGQhb/fMetgI0=;
 b=X0fXXJo1B4n35q96mVZhXgiMXiFiGBb6K52Zl4mK0z62SAnGtan3mJQlbQ31u89mRCgacpcmrpOUuiVhS+OX3uEQGtgPKtj2OcbU5CS8xCA9yO+k5MRW0x4yMeuv46qDJ9DAUaDm2a2OLYzmlMCVQxd6/vZdt9UIQ7mncn+eW076I6loRkCA+u9udN1DLiVEPpvANShAkY6IKcuNe2fBgnFV5qaZrWAgTypqNzohRwPJP/Mw0pykeu+jmZD2qussdeoqR7hSdNq1EbvzkZL8GXU+J41CbXwAK3zRUdXczWenOmF3RuUoTzaGOJoPK4AH56v8zP5CzQgp68RYW59GZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWmholqsoipVEErVDp7VBRKLB1wH8aCGQhb/fMetgI0=;
 b=VKYlAEJ4ZuEGWh7Bsly5I5naKfXs7TDcnqb6Vsc4rDTticToItS40tLPLocBveLC7oys1W11OJTyQVxtaYuvSKIwbJRaR/YXcqw2eeCu0QrgfeGCmIOqfR/jpOAT7FGoWSv8U5h7Urm/Pt9HKELktYiwUF1ME0hTyn7XSz8ZQGefTeaAfGd+jVhDywCs8MFwR0W9kt/CDX2LYHL5rFDkdoGLaNR23QZeetXMf2uTyOCg4ZJf8ba7PBC8ZWngdDIHA9xVHvNnXagoJelYQIyJjXXXJz626y24uSkvpdW5SJeoXTQQ2UnDNu08hEi+phqBkgN5BOAtYEfbwJ4Ic7MOig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20) by CH3PR02MB9870.namprd02.prod.outlook.com
 (2603:10b6:610:175::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:15:08 +0000
Received: from BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9]) by BL1PR02MB338812.namprd02.prod.outlook.com
 ([fe80::dd58:252f:cb73:76a9%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:15:08 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 4/4] ui/vnc: notify client of clipboard availability
Date: Fri, 30 Oct 2026 15:14:42 +0100
Message-ID: <20261030141442.264308-5-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
References: <20261030141442.264308-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::13) To BL1PR02MB338812.namprd02.prod.outlook.com
 (2603:10b6:208:2b5::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR02MB338812:EE_|CH3PR02MB9870:EE_
X-MS-Office365-Filtering-Correlation-Id: e76a715e-ba4f-4e76-0e0f-08df3690337e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|261026121527099003|261026140227099003|261028144727099003|10067099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: 9Jh6k3eA8OsKVDrQZ9c3Wv4NRCwNz5OnjbyI20cXmziXBdkI6IkqscctI7IW9yFDpNftLLf29ws2Y92ofKtFPvy8lAjcLKBz3SskF4USTbG/FI48W5Dd1qRVqenq4ViV9i/bJsWk4R/3wfvGVyiF26GMnJT6+Bi9bDKDru0DbsQqkSiLxHTdeZTDPg2dzowbtgo4WHx2czXToNs6mV9G6fWUwRebOv6k0LfpfYgYe/+G0KwM1vnDq9+6iEX4G0NManSP8HbyrNn/Bdy+HK2IplnYUOvuW2bvhIG35RwlLUNHvFgw7cqmnmKtbHsHsNJRfZafBAJ50EPPwlJfulVYgyCxdpnEGBqhZCeo3Mtu7Z/of5J+5J+WANr67Z5bvWrbxaw9lWtAyBJf2CjvvBDIjFC3dCtjrjDj4hp9XlCReIkm6GilqJwwjmHN6EQKoZLOOJin9ZBu821a/RzRzGgaS61CLnFlWjyS/WHbplbnTNfcuzYGsvng/MvXbR3WbThh7fNOmh/vqnTg0G3IVW5So6KN8LeQ2XAyamhDwDKWMHiwcxW85MJ+09rVs1gNtqkuf9HcNQ6XRo1FLPUES+XWenake1DliwuIMraXhH48rKzbbgWA7S8UkJ4itWYEEI7XeIM9pZwdOrcCXkywejNd0Sl9jzX2ha1V7XDD7I08qgg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR02MB338812.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lysq6sECU+ee8CPSFU8X4gK35jbzr84pF3cIHdWLAfPV/FqTdNWHp94X6Ik9?=
 =?us-ascii?Q?giwz43kcGYw6RBuG6omJM6+UTi2e2wVQ+LZO/MF1GHRorOYljDDurkamdxSJ?=
 =?us-ascii?Q?OB1b3X8dpR6KFM0u2RpEcfvc8QFktjtGBc6/z/Xd1rBMBt8MeMBWtBs2mJ2e?=
 =?us-ascii?Q?JrHOaqt9EnkonSLwC3siNqE7RI7AMkdRoOgFZZ5r7fxYpMhGBEsW9HX4R3x2?=
 =?us-ascii?Q?pnWtTuvGZjdS/J0n6YWr9TILxK9PmfHaKhuVkW2v1WQb0Xk0ig8zNmT3nQPn?=
 =?us-ascii?Q?fIEt3562Ga5a5iHRZnh+h6k0nRwVT44sULcgQ2u6EqYNxkO/1wEqXydzkMSL?=
 =?us-ascii?Q?XA/s9xK+byzbMP12nhcbRNgdVTEWVg/GuP7WYCnaumEDb3nrUaMK4oRjypTR?=
 =?us-ascii?Q?OHIW9Gk1BUa16//6r0PCUkkXPFcrBlgAmMVXAVVmv/ihNaC4iM0QS2nEOfjs?=
 =?us-ascii?Q?4NrgJF6awBG71Jbl72TTsqWy84uA7r76xJBd8ZnnEM1kouKbgJ0BeAwRhLrO?=
 =?us-ascii?Q?LPPhXLpGfHpfMITZo0J+xYftVVqJnSzD6IxeWEoMiYTTaOid5qE86ou04rjL?=
 =?us-ascii?Q?S40TYtV6txCuxhCiGGoXULqkdeQOLQIYRnC0CK1TcZnmT+qNknGH78z3Ye5/?=
 =?us-ascii?Q?+hLYyIcdoQf3uLQ5+RMP6NIZ6A7W9LqspdEVdUi5qtRrcYsMTRWQPewKtcN5?=
 =?us-ascii?Q?mdn3unw/h1U6IgJyv7hvo1qnr9rzK/d1fMSZUVclZPdi23b7Bl3R/4HKGc+g?=
 =?us-ascii?Q?7wcWVZTVegh2xCXiupxc+2gDthlypxeiULfbc/5p/9N5uH5mvbbsl41FuJeA?=
 =?us-ascii?Q?98Vumm567GwNCaGBO1lDnkHtdsWwTWJgxy4hXEGXxBOFPncEZn5KLQDFffNu?=
 =?us-ascii?Q?6rDTFM1FrM2bgPWDxsohmx6rORgvAKVwkYqItQQdJrxXmwIzXauSAQYE/9jQ?=
 =?us-ascii?Q?ReBk+D92cXaYJ6PaRwqCP2l0FlQ0r8Lhw4Hzzq7H5KQzEVzfT6JN70Y4YZ58?=
 =?us-ascii?Q?VexzTKh1GgqMJF8Rex1ePr8Fk83ur/xQa/0bZfRrbfgAxw7UxOew2wgIXvaM?=
 =?us-ascii?Q?xqr2OpPE9DPlPluMtPORTPtsv7y3RJBUYNrsb1VQC/mqn99DpOiMjfM/5EgT?=
 =?us-ascii?Q?O3Pgb7ZPoAQLvVHWDVPaiVtz4XPvvYkik25C0EGafsZ7kiSmtROTtP9Fjxwl?=
 =?us-ascii?Q?Q43x8IFq5bzfjQHCxSZ4GVlwOZNIkiMyW6RSAcmEuetLwzIa4WUBiSZImoZF?=
 =?us-ascii?Q?9GidSAX6YU4hefiUSH6BIzQZ7BNccmDDsVbIfHlJUBaux/4cNSjdCqOlCr/q?=
 =?us-ascii?Q?lxSF6lnk9z6MMTdOasa1N+mYEoF14mT9tnxJLPMNlwhm+2uF3Owp1XRjr8K+?=
 =?us-ascii?Q?OP2s1ZOgk+x7eawvSQMA6ng9serH13ekPpHLOK+57tpnbjwqtYKBcntdoDKh?=
 =?us-ascii?Q?VR0mPIa9jw/ZMhjy2OZb5wyjqp6Kkk1YjBE7F7m/6Omkp13JTe2uYT52grgn?=
 =?us-ascii?Q?9wDSt89zRlYuRv7UBU65NEr1hE6wIgOI9Mb2VVNFjXjR8fU1roBcsO9c4Udh?=
 =?us-ascii?Q?XdtNHbG7Cn0OYbiBJI0QFV9mTPWIPKHfIw3CwtJCX+nseDmZn3EVx/1stf9I?=
 =?us-ascii?Q?+cVFmoekhwfNdjmXpcxoyeIHis++CzIsaCGEPHLocXYhwjxsgFpsLtejUIsS?=
 =?us-ascii?Q?FRweKridbe517BmRY0bRPwummaw88ndu0M9sTqRM4NB9Ku8pZnC1rU6GLYuI?=
 =?us-ascii?Q?QByBsRWNhw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0wOys75LJPrAT06F4g1z9XlJup0ZEN+HBedRVsGs1YJefvRQuKBOyGJ58ix3W0X+cYbe/TrVRJQgilLCrq8japa74hVC+i+3rU3dLBBvzjyeotWafbpWFXXJUkCnrafz9lcbbWKyfISQTmIgdkwgvbFoREklBGgIVceI5EWhTthoFPn0RAkar6p3IQsd2Acn72WUqxg7dkif0UnD8cvQdIwP/bcg9CuJK+Kl975/xZD2qA+NoWGJhEFZGnt7AksvuugvDZX7jfzgUphiV3TLSai1kcruy8q0/sQ+lf1r5yMysbhVKk4HMHIq1XTDacABalEb3FkiXMxk1mSr/VeWyw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76a715e-ba4f-4e76-0e0f-08df3690337e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR02MB338812.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:15:07.9072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJDPE0Pcgbur5xD4H8WpMxUSM3JdHJ5wM1sT0K9tTcBXIhS3zaaaze5Mj1RPcMiY1n623ts8n3EKR3KMxqNBW1BxjtvaSm7yuxb5zqnreV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9870
X-Proofpoint-ORIG-GUID: JgpN1L_CEWKR3SG2UIcs8Yfu4SNnYDgN
X-Proofpoint-GUID: JgpN1L_CEWKR3SG2UIcs8Yfu4SNnYDgN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX7LKeYbBKN/86
 B4M5v6GTNBFZbUDGLqN5IZId/Kc7/O0WCy38HA04wJxUjBPrCyymPuAzAPkrnuzFn5DdtHWsE0k
 oXZBoSZ5pqHcdsHH/NG3kZg+2ktCKmY=
X-Authority-Analysis: v=2.4 cv=S6FMU4sP c=1 sm=1 tr=0 ts=6ae4a66e cx=c_pps
 a=y0MURNDS5CvtOemsVNO2Rg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=I61_8toc4kGt9dKujnoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX2B7SR1iKdHes
 GHC892RjOLK8qp3598etXrfAl4tEODd/SnHnuEcfjCOkjyOCOsyZP+k37DHA/BcirAqy3VFgFaX
 UISeOyrp4yA9OwmcOUSt1bmWqR9wtVNpZkyKABsMPzjkdl8yhdJ2fQp6z/Nt7X3f/3nsRpcIrw6
 JyJXx5MdhlSUlwSkjDe3pf1sC5S9P8DDSKdJVsFvBHc4vm1G9xbktHDdXMH4RkVfJS8wly1cNla
 ZxErg75CRnViq5T/AK1YTWWhCoeko6PyJzgShO0Zdj3e9EboJ1Fdrgqh3XGX6sE4OYra1iasm0Y
 BilBAhVY0pAIiZ5foDoQqNowF0LSzCuGn4bS1b/tjPZRUalDlZQUPiREuZUAscOzwd0TEkUjDoC
 unWxc62pMdlf5CUFciOQL3Fdja7cKxlN3Drj9MGBLr6kDU223Saxly0LBEBFY1mOarF8bWuaDkQ
 26kxJU+O8kT4W1lrBrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support for vnc ClipboardAvailability pseudo-encoding.

When a client requests this feature, the server will inform the client
whether a guest clipboard peer is present. The server will repeat the
notification each time availability of a guest clipboard peer changes.

This change enables the VNC client to determine if a guest side
clipboard peer is available for clipboard exchange and react to
changes of its availability.

Until now the VNC clipboard peer was only registered when
VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
can be registered just for the purpose of receiving peer status
updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ran
if VNC_FEATURE_CLIPBOARD_EXT was enabled.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 tools/qemu-vnc/qemu-vnc.c |  7 ++++++-
 ui/trace-events           |  1 +
 ui/vnc-clipboard.c        | 34 +++++++++++++++++++++++++++++++++-
 ui/vnc.c                  |  9 +++++++++
 ui/vnc.h                  |  8 ++++++++
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/tools/qemu-vnc/qemu-vnc.c b/tools/qemu-vnc/qemu-vnc.c
index 5c2ba3b7a5..c915589ca7 100644
--- a/tools/qemu-vnc/qemu-vnc.c
+++ b/tools/qemu-vnc/qemu-vnc.c
@@ -95,6 +95,7 @@ on_manager_ready(GObject *source_object,
     g_autoptr(GPtrArray) console_paths = NULL;
     bool found = false;
     Error *local_err = NULL;
+    VncDisplay *vd;
 
     manager = G_DBUS_OBJECT_MANAGER(
         g_dbus_object_manager_client_new_finish(res, &err));
@@ -145,13 +146,17 @@ on_manager_ready(GObject *source_object,
      * Create the VNC display now that consoles exist, so that the
      * display change listener is registered against a valid console.
      */
-    if (!vnc_display_new("default", &local_err)) {
+    vd = vnc_display_new("default", &local_err);
+    if (!vd) {
         error_report("Failed to create VNC display: %s",
                      error_get_pretty(local_err));
         g_assert_not_reached();
         return;
     }
 
+    /* guest clipboard peer presence is not exposed over D-Bus */
+    vd->clipboard_availability = false;
+
     vnc_dbus_setup(state->bus);
 
     clipboard_setup(manager, state->bus);
diff --git a/ui/trace-events b/ui/trace-events
index 917d116d90..f5f82c75db 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -45,6 +45,7 @@ vnc_msg_server_audio_end(void *state, void *ioc) "VNC server msg audio end state
 vnc_msg_server_audio_data(void *state, void *ioc, const void *buf, size_t len) "VNC server msg audio data state=%p ioc=%p buf=%p len=%zd"
 vnc_msg_server_desktop_resize(void *state, void *ioc, int width, int height) "VNC server msg ext resize state=%p ioc=%p size=%dx%d"
 vnc_msg_server_ext_desktop_resize(void *state, void *ioc, int width, int height, int reason) "VNC server msg ext resize state=%p ioc=%p size=%dx%d reason=%d"
+vnc_msg_server_clipboard_availability(void *state, void *ioc, bool available) "VNC server msg clipboard availability state=%p ioc=%p available=%d"
 vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg audio enable state=%p ioc=%p"
 vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg audio disable state=%p ioc=%p"
 vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int channels, int freq) "VNC client msg audio format state=%p ioc=%p fmt=%d channels=%d freq=%d"
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 67f710f6ed..7c5bd94cb6 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
+#include "trace.h"
 
 static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
 {
@@ -224,6 +225,26 @@ static void vnc_clipboard_update_info(VncState *vs, QemuClipboardInfo *info)
     }
 }
 
+void vnc_clipboard_availability_send(VncState *vs, bool available)
+{
+    if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_AVAILABILITY)) {
+        return;
+    }
+
+    trace_vnc_msg_server_clipboard_availability(vs, vs->ioc, available);
+
+    vnc_lock_output(vs);
+    vnc_write_u8(vs, VNC_MSG_SERVER_FRAMEBUFFER_UPDATE);
+    vnc_write_u8(vs, 0);
+    vnc_write_u16(vs, 1);
+    vnc_framebuffer_update(vs, 0, 0, 0, 0,
+                           VNC_ENCODING_CLIPBOARD_AVAILABILITY);
+    vnc_write_u8(vs, available ? VNC_CLIPBOARD_AVAILABLE
+                               : VNC_CLIPBOARD_UNAVAILABLE);
+    vnc_unlock_output(vs);
+    vnc_flush(vs);
+}
+
 static void vnc_clipboard_notify(Notifier *notifier, void *data)
 {
     VncState *vs = container_of(notifier, VncState, cbpeer.notifier);
@@ -231,13 +252,24 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
 
     switch (notify->type) {
     case QEMU_CLIPBOARD_UPDATE_INFO:
+        /* ignore the update if client does not want ext messages */
+        if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
+            return;
+        }
+
         vnc_clipboard_update_info(vs, notify->info);
         return;
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
     case QEMU_CLIPBOARD_PEER_UPDATE:
-        /* ignore */
+        /* only guest side peers affect the status we relay to the client */
+        if (!notify->peer_update.peer->guest) {
+            return;
+        }
+
+        vnc_clipboard_availability_send(vs,
+            qemu_clipboard_guest_peer_present());
         return;
     }
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 656768f9c9..8b1d03ef24 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2191,6 +2191,14 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
             vnc_server_cut_text_caps(vs);
             break;
+        case VNC_ENCODING_CLIPBOARD_AVAILABILITY:
+            if (vs->vd->clipboard_availability) {
+                vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_AVAILABILITY);
+                vnc_clipboard_peer_register(vs);
+                vnc_clipboard_availability_send(vs,
+                    qemu_clipboard_guest_peer_present());
+            }
+            break;
         case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
             vc->worker.tight.compression = (enc & 0x0F);
             break;
@@ -3459,6 +3467,7 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
     vd->connections_limit = 32;
+    vd->clipboard_availability = true;
 
     vnc_start_worker_thread(vd);
 
diff --git a/ui/vnc.h b/ui/vnc.h
index d8b0070396..8eae550c96 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -171,6 +171,7 @@ struct VncDisplay
     bool lossy;
     bool non_adaptive;
     bool power_control;
+    bool clipboard_availability;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthzid;
 #ifdef CONFIG_VNC_SASL
@@ -422,6 +423,7 @@ enum {
 #define VNC_ENCODING_DESKTOP_RESIZE_EXT   0XFFFFFECC /* -308 */
 #define VNC_ENCODING_XVP                  0XFFFFFECB /* -309 */
 #define VNC_ENCODING_ALPHA_CURSOR         0XFFFFFEC6 /* -314 */
+#define VNC_ENCODING_CLIPBOARD_AVAILABILITY  0XFFFFFEC2 /* -318 */
 #define VNC_ENCODING_WMVi                 0x574D5669
 #define VNC_ENCODING_CLIPBOARD_EXT        0xc0a1e5ce
 
@@ -466,6 +468,7 @@ enum VncFeatures {
     VNC_FEATURE_LED_STATE,
     VNC_FEATURE_XVP,
     VNC_FEATURE_CLIPBOARD_EXT,
+    VNC_FEATURE_CLIPBOARD_AVAILABILITY,
     VNC_FEATURE_AUDIO,
 };
 
@@ -541,6 +544,10 @@ enum VncFeatures {
 #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
 #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
 
+/* ClipboardAvailability pseudo-encoding values */
+#define VNC_CLIPBOARD_UNAVAILABLE  0
+#define VNC_CLIPBOARD_AVAILABLE    1
+
 VncDisplay *vnc_display_new(const char *id, Error **errp);
 void vnc_display_free(VncDisplay *vd);
 
@@ -637,6 +644,7 @@ void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
 void vnc_clipboard_peer_register(VncState *vs);
+void vnc_clipboard_availability_send(VncState *vs, bool available);
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
-- 
2.43.0


