Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038B8C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsN7G-0006rS-7N; Wed, 12 Mar 2025 10:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tsN7B-0006nx-Sj
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:31:21 -0400
Received: from mail-northeuropeazon11023141.outbound.protection.outlook.com
 ([52.101.67.141] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tsN7A-0003ld-4S
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8YRYt/upvSGdu8SeC49IRxvj2H3PIryeBvMI0bw3vQ1GUFJnoOZxr3PinrpCV61vwZnKnvNTflxkcISaSoLJqXZVTSJPZ3FwKN6p77f+PbjL+Ejrl6P/wfQLESRv4vulMecVjksLF3UmakW24EFe2vTKlS7JQVVaXZaeHII5zrfLXoR8eDPkCpseG/7FmHsoNi2W5kRL5rIDugi3yJCRu/azCB9s8iwjSt4AGwoBxT+ypa8fVee7vSPJd/ugPCY0w8rYbkwpKQmP35gfVxAhFOViYDk1rvYuNvUYC11VCGFWFfzSP91NFf7DKbSv+Hh/FTOItiJxxiAsQsHHvsmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=aW5IOtt2owuRMgiNHV8zXTK0THv0rMyxLL9H+JwOLEzjNOe8q4E0ayaIdrTIxYEUzPpxiwKEw9b7cX93vTxVW67V6MZKoRURxADQoOfO4IANCyG8I1tQmr3oTUG2VgsSUxcrkY/vvehM9O6B76xtjb9FIuFW6sXOdBwzD4TGSJmwn3IqWXrFKBRf0kuciL1FC/af3entMQNjKvShQ1GMrCTPfBlLsEsFzYCf/VYQYpmB2wW39RLo34F+dc6mqV4DbWkImJOL6P6BEPrj+ROleYema+E0sJaAZ4MYR/LnqGmIyCb6MxAevrAtn5t9Ik1Hc3XacidA4aeWnyQqlPbwsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=o9u/rdNum7Bycl3g2VMk1t4aEowLCdqPgfqfOFI3k29o1IKrA8fhKqhuKoTRJkYSX3jQ5fgrbf9cVTGd5TW7qZiap80i3Edxy7sqaU4hlx5KElfHhofRfa3osZ9B9zH6qAtYL/L2Wlg1cXcSTZEQUf2qw6TQiI7xCqtpuqlXC7kF65ED5nUm5HQ6S1+P874sQhR8MOfudnIZfmXVDDpAc/4Gy/GLJdnZ896WEIl2KCf3IJ0Sg3o6S+APylmyDoRHmfoqsC9pMn/az4+OxfW8hsUzC9SGhayaeltK8QRYommn6VQjOORz/J/1tRbad1TIDUFFOJKru/ECxLE3UR7cXw==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by DU7PR09MB7967.eurprd09.prod.outlook.com (2603:10a6:10:5b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 14:26:12 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:26:12 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "philmd@linaro.org"
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yongbok.kim@mips.com" <yongbok.kim@mips.com>
Subject: Re: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Index: AQHbiHBMKhjxNs/1dk+vCUF69yvpRrNvpGeA
Date: Wed, 12 Mar 2025 14:26:12 +0000
Message-ID: <20250312142545.113929-1-aleksandar.rakic@htecgroup.com>
References: <20250226170246.1971355-3-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250226170246.1971355-3-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|DU7PR09MB7967:EE_
x-ms-office365-filtering-correlation-id: 8867ae1b-3112-4e52-100b-08dd6171d720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9NM5QZBDg1hI1PkfJ4vQsnN1O751KnF6e0/QK5uob2eJJg1ohLpzVVE4bf?=
 =?iso-8859-1?Q?bgLJt5DFw9C3uPhj027TOh57wWX7HVwv5bB4IIXK1C9K4q6BBHNK7E7GNn?=
 =?iso-8859-1?Q?67AW4CptE2wnxDfvNh+fvGkxr6TOwD/jB4YopDLRqXp9y+zbrgaVStvphg?=
 =?iso-8859-1?Q?sJ/DIHVt5/tr6+gxns+atbloyouEslqyL6gqfBNcEFYlQXkDNti9ogE7M7?=
 =?iso-8859-1?Q?K9ALEDy5C6GH1GWCRnw6PQ9gyFVYDjzEnDWVUcjbRINWwOHQY/trGagsJU?=
 =?iso-8859-1?Q?T9HxWsW191N8hfhiTJMrWse8pcJPK5gFDX/3WdDbI7/qmV5DfWanWaphAD?=
 =?iso-8859-1?Q?ie3H6KmjnrXFxUWltfm/spIFYbjSth1yPvpL5v96oMD0eaOq2GbLMj00zg?=
 =?iso-8859-1?Q?ERkle+f3ebe+3f4KIqBrEznLo57cJTOL+/NP7zOStPeUH/cA9zNeLA7sUr?=
 =?iso-8859-1?Q?gG/5lPolq7EjE4LgSP11H/JuJdJa36WxXDht5tjpCp0swnCPJuqEal+v31?=
 =?iso-8859-1?Q?JTsPdW+L1EDYoS8SkP6fA3apgNkp4/nWqb+ru+uhZy1ZjTDPcIgaw1ac90?=
 =?iso-8859-1?Q?34AbPjeoFO9jn34rOuZ/C33ajMHEknsZdU5AKhbHK8Ze3St4IZbTxc0TBj?=
 =?iso-8859-1?Q?PqqakGo31jpujqUVgFkmXmWKf0+zgQOdfCyS+qAeNWcEdiyUiqlfOzP2le?=
 =?iso-8859-1?Q?UyNsQ8AgzIE5d7ZaDMKOibAfCG7AVT7Hc8rzEUK7B/hS3oofUv1WKZa0Q8?=
 =?iso-8859-1?Q?CJIFcQFhv2B/ztgSHpT+bvRDUGMpYAmX27r+XoyqRTVRa7obUsFZ2Qf0SX?=
 =?iso-8859-1?Q?JS4duTjjQE5xZFEXC8TypRY6QvPNx9FNfVyKQ/eYAqMlvEvobpcWbn0hWt?=
 =?iso-8859-1?Q?WgZp8xMFTEeTO2hi67bxinaWeQOvtdf5slY66xVKHchiRcE33W6/UXvpKK?=
 =?iso-8859-1?Q?DV0MetCWbbZQJ1ww6TjWMguHIddV1S6A9sISXEXiO2fU+5WyX5uuPz8/Nn?=
 =?iso-8859-1?Q?at7k8PFEVluwJCrKHgclfdZL9k2KbFdMRAug97t+/MWd2hfcDUjh/OkwVi?=
 =?iso-8859-1?Q?biAw8vFeZsjrjSr9cEZIci/2o0zGc8NEIWkAtPzuFxvy6i6+tVSCbtUIn5?=
 =?iso-8859-1?Q?YwTquJR7DuZALWYaf1VjGSJJSnmVCNYwOwhaQiQnDX8YG26MIMDHAitgWQ?=
 =?iso-8859-1?Q?EIHUUng2s+j2IBoczvN4PLwiNLC9YBv8zO+1rSlHjSGp9v6LqPDznQRdoo?=
 =?iso-8859-1?Q?ulhX/Di4ptMVS6ox+K6tWBBiA+bLykca6Dm9jgz/EgAGTG/Lc9/Mvt2qzB?=
 =?iso-8859-1?Q?/Uq+fdR2vcj0nsbxmC5dptSeLa2wXNFrNxQ2zHA7TYgJd98sVXWveAxGWK?=
 =?iso-8859-1?Q?gojt38/ppZkZzA5RBm58skcRpMM4e+SmDEUYnJ3KniJXeNPWIjT4YunV8P?=
 =?iso-8859-1?Q?2DCf3OKwQgIspWUDeWM1s2ZYI/HistB/epGu89G/U57Jlka/R6dNcEfsme?=
 =?iso-8859-1?Q?F8uNhweskNQvGaaMo6PDua?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WHmSqxcseLm2OP4d//RFs3ncNrYZoX5Dj2abaBFWkKwztjYLktikK41cbQ?=
 =?iso-8859-1?Q?p6tw1P6SJY9/ZkrleCXhVW8JlaPPMT81hd69OANaMXxmC5Fakzfg1Qo+HI?=
 =?iso-8859-1?Q?JXJZ9idzLUuQuYHaA8BwpNUy4nsK5g3sPXNV+VEtCfahmNcJfdIaHS93Rd?=
 =?iso-8859-1?Q?R/iSjazk3N5mptbup+5kQtzgjxjcFPSGKM+UL9QvILKIrMGCogIc9Dl1Gc?=
 =?iso-8859-1?Q?XbtEfL4sjC1UkbrD/hMHcNa9DOlnbOVSHRARIlJbGQLqrDL20191yPeePa?=
 =?iso-8859-1?Q?lPj7hTFUZWNKcoEdgHyIHn/CZUVpIbnRrgY4z3e5I0yC8qnjWnXENsjQDM?=
 =?iso-8859-1?Q?uY10Ur4M7V3t/2qRVWUII1Oh7k4xCMtC+CT2Q8v+StMMF+ITls07xKSpUV?=
 =?iso-8859-1?Q?6aaHYIzhgagbchv+5bdlijLHdalM0H6IL9cow5CItfwISKN5wcs3C1PsjA?=
 =?iso-8859-1?Q?5KvRtN+fU8yi/hDk/R3MIcSTCbmr+D6xttt8yexSPOt+6Ge5bAGA4otFdL?=
 =?iso-8859-1?Q?OLfUfGwvtJZLnNy/FnjY5sHubs5iDUOCvnshfKWrnC8FcPZHll0CiRgkzD?=
 =?iso-8859-1?Q?iNPWqqA+u+P+5JBjGgr10Ip+wHhvD4tIHPdCU4NNItMsDvFArD71zfy1cY?=
 =?iso-8859-1?Q?Fx12Ry8itVnzZ5yY+FzKIWIGGMdtFBM0k8Y6YRc49zVBlTwn/SjlWn2E90?=
 =?iso-8859-1?Q?gLU/LqNrYjx7uN7u6u/W3XkSVE9m6xogfVY61jmDhokF4Zu8P2Mh46BS1O?=
 =?iso-8859-1?Q?pFZeWEhSDGDWQ36aHD2oMtCxDnFmxtP62XMyFsz1BvZZeUHtqwyE0oSpIx?=
 =?iso-8859-1?Q?hvbOOzImccWPxANzOvr3Nb9hlW4Q8GzU3OShKnlJSGakwSDgbcKW9zgj/8?=
 =?iso-8859-1?Q?hi0t57vkwGPnkpddBziEmeyxYyvPyN2GgQPUBXgUKTd04aAovaojkcPVW9?=
 =?iso-8859-1?Q?Q7baoR4vBG6EesbsFSAII3rWwvsBd/gFIVvAgdZ5nMsn06vilyEj77zDyG?=
 =?iso-8859-1?Q?niZK5lohJs/7hAAzaVxABXoYaKOolQ9CB+C4Qf8jom0HEt4NOBkb6I8a1U?=
 =?iso-8859-1?Q?LXAPr2qSn0GfdGOyWn/hKkQ/pyZQM1Nwrdsen24ab8veJ4kZ6cGddwwrw9?=
 =?iso-8859-1?Q?fpjHZmA2XpyiWUnRQSvBaKgTqv2jr/AZ2gqqgAwbt+yRFYefA2pQzGYLb7?=
 =?iso-8859-1?Q?TOrlW7umDIz022Z80xth3SVWsTMwTUZwjgGiVVLmDKAehiLqhF0Peqw6OM?=
 =?iso-8859-1?Q?hIG6/UvgUWzZ3G6NsAcXhWyX/SpISfVDBW5RKTBPp9j67jmRrgzOyeXWqE?=
 =?iso-8859-1?Q?aWB5ovcLf6ZY4FaslbPc7XI6xS3QkoWrWvZmNAc9IyrLb+pa5quGgpUAiP?=
 =?iso-8859-1?Q?7KT03PDHfyh/AbA0mM0sqCJBkNsj9BnCTsSKQRWd2GSd9KxZR8vZ+Txo1h?=
 =?iso-8859-1?Q?y0wpTofZ6IDkWd4eSlmjJilH9yUCaQM+7pGFjULXtvCXNfRKXCCgI0oM7v?=
 =?iso-8859-1?Q?4LJi1xXbZRaVgFu2PmYLaUIGr4vktwYxZBpR/wGzvU4xVPqVeFh+/ZVUEe?=
 =?iso-8859-1?Q?ADz6BLOc1v6HANUpMY1Red9zucnBMnpH2gQAmMnYpdOd0VNk3uwXS+1fXm?=
 =?iso-8859-1?Q?d6Uw1vheUU8b1bTPEfMJ4zo2lgDgo6RHXBgXwO5NAptfpQ/mMIaIzcW86o?=
 =?iso-8859-1?Q?bJgiYmN6Tl5o6HbsTI4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8867ae1b-3112-4e52-100b-08dd6171d720
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 14:26:12.4550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcBqfNKrtDfgSItagnD0OhzkeSsfcx7Q4j6rmGkFKq+qfycN5ZIr+lkUTHlc/I0RdHZFQ647O0ruG8NKnxFopqvtwMECf5dSfxF4ZRFk5z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR09MB7967
Received-SPF: pass client-ip=52.101.67.141;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic=

