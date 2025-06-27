Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68137C7EE32
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 00:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUweV-0002R9-O7; Thu, 26 Jun 2025 20:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUweU-0002Qw-4S
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:09:10 -0400
Received: from mail-francesouthazon11021092.outbound.protection.outlook.com
 ([40.107.130.92] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUweS-0000f7-T8
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzhIs8fx3uSMnLoHLbCD9gNGDP/qZRF9VmjK/NmXGn0RjuHUcu7cs9ohud1AkXeJT2j0zUU/H8cmLTs4yOoMJST/rr5dzvYvwm7hE+SZegFvPgdGd+0DOHbgr7pNAIZ99UyCNEI5c9s/GY4ZKFyAtZ+PZCU8THjxSTlMYreFBpqz+sBICLycJKy6XDaNqb33VGDrnTV4yQ0psR4HHlxLQxs9qfeZp2rXc/u0AIIk0pXj0am9xGWuq0BtQkeXNYo5zH292XuTl9SWhdVIufoSF7ovrSdc3H25ebCtrCZlMjpyP6VFAAQTJaEsT5vc3rGgqD6fifE2AdtmDG3t2v4HQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDaZvst2H2/CGz0YFtrqfXWE7pzWP0McvNphF1aASMw=;
 b=tZOTKoaFqNUqoV8Ha+IzfhPQWcNf+8PLzur1RubP53gl5+h3oYYBt1zVHIvou0ipTGQhm7DlbVFJzs0qMPxYhFTn2iMEOod6swkc3j+NX3nVoFjPQ1VVEkE4dDc2VbwBoVyzwzg4t+IZwoX/RNZwP92A4sArLeyScr5Q0AUb3opNhch/z7m6rVEn94cvrwCwu8XwDybad34bdtFLj3jxa1IW+d0WcpaC5NA0Ui0imi+R1UbZ4KqkK8Uz2Lz9DBYetZK/R133Rdd31pC+tXfsEo4qYOiL98bXVFXEWU53UF9X2tvpP87KyEaXQmZYtkpLBavnraVx/9nqhc0al2e7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDaZvst2H2/CGz0YFtrqfXWE7pzWP0McvNphF1aASMw=;
 b=CO8xNubqakqo4n5ZWk0BRgejMOgB/unwMNV1b6Gfqif3/qBvOkno2TAP3S/vXVROfcQ9evU9VfD0Q1ugs52BvVqHzHqouDtlAr6YqK5bIqjmFELCsDRh+l5CJ1gjVd5CcmebzhJD0dYSNb5IpIAx4rbwxh+JyBt7dwUZbKtRveQvyN4StuOlrq3w7JJrnxOyut04HnZvMG8z9LMS9gcgEuvrgtJLzgSTeAmf+ZMdSXXMrKoWQHHvMFRXn7guHSXXEufTfOhy28euIDtrIlSbEa3rZsal1Bjtq9XU3p65c3rUyM8KAeSCUgbKvsEYt2YYBpLLBhQuT60wJoZsbotKlQ==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB6925.eurprd09.prod.outlook.com (2603:10a6:800:248::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 27 Jun
 2025 00:04:00 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 00:04:00 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "berrange@redhat.com"
 <berrange@redhat.com>
Subject: [PATCH v7 0/1] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v7 0/1] Add support for emulation of CRC32 instructions
Thread-Index: AQHb5vb85YVcD5EnLkCvOH5v0yDaQw==
Date: Fri, 27 Jun 2025 00:04:00 +0000
Message-ID: <20250627000246.1811052-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB6925:EE_
x-ms-office365-filtering-correlation-id: 6827d7c3-1f4f-40b9-996e-08ddb50e1e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?h2DxeqicKIMHNAQbrimGsZVII2KaZI17+JRt+GZ/RAOEimX4R3ncSc8ItZ?=
 =?iso-8859-1?Q?7DtITPzPdCbLGHAcUEakuAZUOL0Geiuym2wIBhXFBRTrta5yasEnKfZhLr?=
 =?iso-8859-1?Q?UQ+IBYqKX0h2Z73SSPHXmlDdFg9GgQNKxZy305QtEKbsT000Xh2lBEqu7g?=
 =?iso-8859-1?Q?LddGyXNNfPFhSydZstdpgMnY8cur6F5tfeHOsIeDY4M7JEETTtrK5/kaSu?=
 =?iso-8859-1?Q?+YZykdEwMDrqO+cNxqiT6lovvfke6im3G+5BD8CAhCY0gXuHgvPQkrn+Rj?=
 =?iso-8859-1?Q?JXGwD5FCTtNAZekjA4kw+9Y2hwknmIsnFpf/9v7MwUsRx5oMLoNo8SBrFN?=
 =?iso-8859-1?Q?ZkYb20yxDONLvSQ6pFsQy3/HOTZIhqxijQM8ep23QIl/eoSLDtM1FG32wA?=
 =?iso-8859-1?Q?jEk4S175Q9JKI2F+acHzykpcv/poNvU8gLw9jL7LMexNIkHA7h3m7zhna8?=
 =?iso-8859-1?Q?nrMyonLw9d6DUxLAQzkJ7cXzZxmZ+qHcdG632Qxb6udzLjgzB4W8rekaad?=
 =?iso-8859-1?Q?t1RY66NMqbu8B3d2Pyp7x8YReEyxJIUs+SOW3zVEtdi2Cuh/B3JBQTbMt4?=
 =?iso-8859-1?Q?TF7PCWs/NDtYN8h+tdVghPOe2K6jGJN5NPiTGkwPo6DJN+TNK5zm2Ug/lF?=
 =?iso-8859-1?Q?Z2QVbbniRda6gkVMbOKa36xRtOuOcfb2ocTcJtONkveHX6O7004Y1AjoMA?=
 =?iso-8859-1?Q?6SSOPLkRrm5h+RTtmYLH+MEFKbwLqPWF/yqcDkevftAZReEUxp2aUlJStU?=
 =?iso-8859-1?Q?fysOL0KgwBWQMX22d0ZGVEAptJr+zVDBa/AJyvszMzy7qhgcDWfxCB4qzH?=
 =?iso-8859-1?Q?vyYVRzpjJrLBQkZcq7mIvNun+qQQ5d7mJPwUOg9E7MAcXqvcdgHAgmyLaS?=
 =?iso-8859-1?Q?uHsOfCDTEPzCtMgzOIHyMMJxyZlQNMEDjImrssXjyLZVH+RUg3EpZZ0sVd?=
 =?iso-8859-1?Q?1dRv0rCMEBdWWR6V9njU+GTFGq/D0qI1vn3qx8RDvFLwLpq6atUfdSMZ3Y?=
 =?iso-8859-1?Q?DokT4S4gTLzWulkcZiiT5KcbYDm1oB3/PjXiXRijRIJcIchkuFS5czpb6M?=
 =?iso-8859-1?Q?iuCRISU5e6d4DQy5WHYVoPzMqC6UTJ3zEl1dePqfdkSEDm0pEQhwE73iq/?=
 =?iso-8859-1?Q?GpZAVh/FQgOGQKck4Si0C76hqGHrIX5GoAtSYUNtJWqpw4HyybovQdKhHI?=
 =?iso-8859-1?Q?5amxSdosocV0wiWtxmbXCgzYiNxLq5Z6ZqaAgAraGz6JHlImS88ZNYzJ7N?=
 =?iso-8859-1?Q?xiOLYOXd/LDuLQYEfifxGnc8RrDFysPLmPt30A7pos5LEt3sA88rtZdKr8?=
 =?iso-8859-1?Q?Xxt1Z2jyDBX9X+zc2w59xmm82eaVUkrcfJBDQZJV5auQQUN4fiNpH5Kx8R?=
 =?iso-8859-1?Q?amC+v2pj/nQhIfzBt/FyJhQGBDQe0mTpyZnQsIZvNNOZizT5iQr6HmV2q7?=
 =?iso-8859-1?Q?tgKXfYitDgBoZN7r7dqLisVhwf7odKC2TIIBkzJyWho9SKoVzR7cKtAA7u?=
 =?iso-8859-1?Q?3q6cQzLPSM5qOdJm7hdvHwjWp9ihYWK/Lg1mRBt/T6OQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7EsfgI1Y3Gawy1+sgCaMZhnl3RGSiqe5veW9brSp3X6w2+H2mcDG/uEER3?=
 =?iso-8859-1?Q?p1RFj1AYiYSPKFSm0Urrf+a1IxSdt9saOHTqv8n8v8aSegC/5pZ0fVh4Q2?=
 =?iso-8859-1?Q?dG7w8j6ncqfMnZfcCs9eV4DO9ZKqNA6TWOen7xIHu7fGGH0YfFbOPRkCIs?=
 =?iso-8859-1?Q?1UqzWG4z9RfDp3NkxXL/Dx2fulo+ffdAb67D6srD/1wV8CHWyiK4LeG0eg?=
 =?iso-8859-1?Q?vnJybMm+yRSU62bizirlXVQlx5Pud1daTQ7d8qGsoPS1kr8jKKJElBWq2H?=
 =?iso-8859-1?Q?QbzijCCvOSp+nF7DeSXR90saPLVj0J4rNZBMR4X3gSO0QaeJCqK+ZqT3QY?=
 =?iso-8859-1?Q?lBX3t0zi/b3Yg9l+ztLXenRa9+yhubFwZROYbauVmXyXy0EhyTPhn/55JR?=
 =?iso-8859-1?Q?+S7x47Qlq8eesIgElYNh3XwZmaleTou+ygIxapOvN12i1TSaG6DuzJHOsR?=
 =?iso-8859-1?Q?umm72EGAx2b0jKHCJOA9AjuJ9m06LOZBL8wncDlBB88gXUU4GUaqPl0Q35?=
 =?iso-8859-1?Q?7JyImlPw1Fk9RYXtLNjLAe4RVGQYcia+i86Q2wDkPKc1G0sieyXBRqhu0Z?=
 =?iso-8859-1?Q?1tEJ5VOhI2fDPxv/9zDDBRkv9eY9sulzGPQQQyP8Rb0V9vfcIo47RB1F23?=
 =?iso-8859-1?Q?JbgAjhGSBiAoPCbRsT0fjWlgslussSowgWQTZPZ76ylH3WwECWpzM9DEbN?=
 =?iso-8859-1?Q?FoihDuQDG9lnNPphKGOHolzM7mEvvap2Y4y3u8qeRRNaan0pIsA1z2SB19?=
 =?iso-8859-1?Q?vNjp5o3QBBIDmQnUNpPPuWa90oCAvBNNYf8e4uFpEtImAPCNLvz4+QqPGv?=
 =?iso-8859-1?Q?6xn3HZgg3BuGswMflUk/Uv/aRerV/f/N9lrx0gRjha54rInuNpLrRH5ypN?=
 =?iso-8859-1?Q?2iipg/aCa4kCa8HxPVGvy1ISVzEUA68/B8FqgX9SuOo6ht7KSLVExCU9dZ?=
 =?iso-8859-1?Q?7dsXflfLgHItdtg5MaoJ3+pFhR4GHu7bJpITVrygXrwBTOq1v9/A02uerB?=
 =?iso-8859-1?Q?j+yTt6VpdnydXisgGJ5BBDKl5bVRaficru5BhdV8Yy8erQWlmZLxv4pveQ?=
 =?iso-8859-1?Q?CBVSBgHd9ehVqo7TwYdh2rWvY3sGQxh+ydFZ0DIQ3hPi79eC1cuZHK+5zM?=
 =?iso-8859-1?Q?NK/eApedXsJZEATUzIJOa3bE/GF2OEaAj2hoIR28Bm6icw40OeMpABy9eX?=
 =?iso-8859-1?Q?pGAXhCp9/3ZydZYahdzb00uUKiFDpvWDv34HfvXpgim/butFOw7qOtP/hw?=
 =?iso-8859-1?Q?9DKGs8uAcIC+Dvia1lwbfmf8XvzaKH8xNw9zakSfj73rGfg32raNOKm6dk?=
 =?iso-8859-1?Q?GYyal/TvIpBwy3z6hut9Wo48iqpQus8B3jOdI+0qXHEljLV6PlO2IC0jI7?=
 =?iso-8859-1?Q?iNXxRegTveZYZpfWAtqjABRQColo9zXjvWIB+wWDCa4y3jlsNzY3z77S/y?=
 =?iso-8859-1?Q?O6K4AhD5W8EYuLl9QohQv0HAtVXQ7+abF1PkYisJ94XKkqv9QpEKt7opN6?=
 =?iso-8859-1?Q?VdvUIA5JbQZ6QV/4Urh3OfBYUnPiDKvwiU3RL0OWCVVMv6qSnHxtzIyokj?=
 =?iso-8859-1?Q?QFs0G5oSV5OsPKJPxdZwk7lq5T/xe19eSKJMUAl5yxgdCvcAzJ255GMm22?=
 =?iso-8859-1?Q?rpIi5R6Yq1u0T3fExlSFsWxlYeDC4F3FXCeysrzlZE68tgqEFu5z+mw/fI?=
 =?iso-8859-1?Q?xZsj0mSIpfvF0iZVe7A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6827d7c3-1f4f-40b9-996e-08ddb50e1e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 00:04:00.2813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtUzOShAQsY0uk9PmgaBzgHB/z5a3487OuP3QKfKhRMBffvHMTZHL2HUEPOfJT9lX3fK8oRkLqlhPa20/qX+QhA+FgZuCip//QzN2LWFZBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB6925
Received-SPF: pass client-ip=40.107.130.92;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patch adds support for emulation of CRC32 instructions for
the Mips target in QEMU, adds tests, and enables CRC for mips64r6.
The CRC32 instructions are available in MD00087 Revision 6.06.
The disassembly for crc32 is hidden in commit 99029be1c28.
New opcode is implemented in decodetree format as in v3.

Kind regards,
Aleksandar Rakic=

