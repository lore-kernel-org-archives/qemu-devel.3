Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D26EECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOb-0001OA-3J; Thu, 05 Feb 2026 22:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO0-0000T5-Kp; Thu, 05 Feb 2026 22:20:02 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNz-0008F6-8U; Thu, 05 Feb 2026 22:20:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O95d0n9/caonYYeDjpTYmq+ZlE1ND8msmT05LSCgyldPVslRgjYlsTRMZKpedK3Xx5pt2yUqaDzfRumd+Pq/1dWYq8Kbv5DBz83Y0blNmpRi63E9wbjQqI59OSwPn/Pdbty6p28lsA6jrnsmlQ6AGjYdeknXqdgu5tQZ8E8LrK5HUHpgQJO0U74cjlEJJ5vIXM6rf5iehWKyDzKTclDhyoyGTFfwAQ5FcEjNnUaCyzEJvQ3XiPibyfWYDhzdWDwDq5Uf5gouVBi1lMKfIjzYKgJ5Ye+V0q9RnVfRhHeRndnjJoyYs3Djpd3hSbW2EA66Vk17YG8kykNEDxhCkW+VJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VZdGZBj1HU7FMCeqQnQO36W5ZCyrczPIb0UPVMklGg=;
 b=xUdDHBjyoxRS026JhFIQBLWsQE5azgb2x80XYwNzFd31Dk0QyBb0tqvFsHVn21ffDAaJ7EmUEfIHqmhdZkVqdQZT18InlAC+dzGsKgvLgYONU2wOuuDtOEX9yGLlWqaHSSs6dH9Huv/5UoBlXLfxNOv9z4X0wdZf76l4rSQS+wHebzb35fDEdroQs24ErFea385VaE1+kQXQDv8KRk9BJaMeWy8sFr/GKBVjx9uCwIUH0XUX2tBri8SEznw8Ako1lsiDzXtslyhyjbxZkZ2AVCq/hPo9hDhx3VkDpkuDDN4454kZDIZI5lTn9QfiL005Vz80nB/mzdjiaXVYQhl0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VZdGZBj1HU7FMCeqQnQO36W5ZCyrczPIb0UPVMklGg=;
 b=jrYQeTuegF/mLxAeRLaTI3e7O2RY4k3B/FEFX2dSBZF2uu+IahgxxiFoawK+Ci1UvwJy0nVcbNzgmuraJjPgQyX6KevVq1DXfbr7nqIWKlF2LKjXYF25TJ4NfJi3cHlPSQhuWo9RXnPzbaA23Tz4T0QcRDBH12BnfCBRP2Mmwagug07Znv8iczfJVs6gZjjbYH+emYpehDnhsq9bJ5Wl5D93b+0lyXIByTvicAWzAlKnddUnyEFltyny4Uv6ulAFDhR34fkkj+0GrDa1MKxpbLXCMkL6L8vJ2C6g+xkWZk8OHob8dltp6VcTSgSpAtHx2+uEq4SF8Ra+lVhjsVTMuw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>
Subject: [PATCH v3 09/20] hw/i3c/dw-i3c: Treat more registers as read-as-zero
Thread-Topic: [PATCH v3 09/20] hw/i3c/dw-i3c: Treat more registers as
 read-as-zero
Thread-Index: AQHclxdur2A9tjucQUqE7M77OVBBEg==
Date: Fri, 6 Feb 2026 03:19:40 +0000
Message-ID: <20260206031926.3227848-10-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: eab0fddc-81c3-4e8b-6e39-08de652e90d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ay2h4aGOY/zoz0GPwgoP/8WHPSBkd0sk+/Q//ByvStUtssJc2QPg/Fz/dq?=
 =?iso-8859-1?Q?bJkptih0PP2YyiKgw96R1gTic1OX4sXdt4G4iDA+vUYlqpZSgFG9/qs3TS?=
 =?iso-8859-1?Q?FAVBZhm+XXuGXv5NDq9q0S41iCBjb7YO0+u8tk0qm0cWy2KjAiThserhMT?=
 =?iso-8859-1?Q?448cMqbVmQmiA1Ki/E/X3mVcmzsVCNjj8q9PJEl57FQTK6IUUiJ8ueqHcS?=
 =?iso-8859-1?Q?YxhgAUJTkbM6nj0Oj8QgWINIAxarwT3coXPCcpHUnp8d9Wth/EZf3hJr4j?=
 =?iso-8859-1?Q?AXfhxm/miuPUE2Eg9VlqyZ3wf3rGzN5cI2gTV1lGxyD/bBQza7ih3M6jIQ?=
 =?iso-8859-1?Q?MNAVnbjXhHUBNmQIVcb4UQZ30Xoi5BekQee93WQBFR/NLiU94ApPVo8Gew?=
 =?iso-8859-1?Q?QVRIu7i4MsxRJ5S7XV/aoGvGghxGXWyZtfYFAWkkXHatWUu0kL4fzbLlwg?=
 =?iso-8859-1?Q?5w+qO6U2t+0EEH6QPC2n7rXAnBlUOxC3ZOypKzi+P4r6bvtiW+yIyl/Xf4?=
 =?iso-8859-1?Q?woWr+TfM8v2wzSf/FAYPzCuqRJLkKrSsRPveeKnBJVkqfznL/PRa9sIbnP?=
 =?iso-8859-1?Q?5l3QiibKzLgCiFFgld26UO+ZzhzBBMyHicI//d9qM26nHd+uuRYgdM3BHU?=
 =?iso-8859-1?Q?k2Vs/uv5ZOz7QlTPv4Ldg4HKjRb/ghgV31buC2JcSu+qxSUnfSRZSna2GT?=
 =?iso-8859-1?Q?+2AAw3IQ5IeC8ny19a1Va78gkjrwUKJlRTggH7JCo3YOORTShSN5221js4?=
 =?iso-8859-1?Q?ZaEjHkblOywkngV2zdk0fKwPAmMofwYy+bW1QE6jz6CnPchPx1pAXWBk1i?=
 =?iso-8859-1?Q?VDoGhIISHUQJCz45yIO8xox06t9euCcsYJ6670Mzy8JmfkYu63+XyNiCca?=
 =?iso-8859-1?Q?LN/vU5kA89xOvtBd1NC6f5uloAtCqTKYT4fBfTkcRX3qPxJi2iNVLZfmVq?=
 =?iso-8859-1?Q?bx03C8+PbOF9WjyakgPaMN4jT1yFuVU0iyl3hPPv7SOglJG8mvdu0McuTF?=
 =?iso-8859-1?Q?ofju78A9EHZqBsMMcfeBGpjYvhWqLpQUwfd6N769yS/xM874/MCpX7e356?=
 =?iso-8859-1?Q?LjQF2/y7E4+BFWMhPZp2CoTZYHuc06AtsGW9PtpIbm1uDlz5HZVml3DxuC?=
 =?iso-8859-1?Q?pJ69cohmsmFdWLfNbp0VjIKIaZRDHmeOvLBshNh2M1Do8iW4xz+1JHfNkK?=
 =?iso-8859-1?Q?7mmRPATgYCGcV4x/qqb0VtTTbfxKuDw/ItnJ/ae9L5gXYMeljwnsbQymQL?=
 =?iso-8859-1?Q?skBEwdyqvXhdRXmQfhFkBF8I6AqSQKpFAvqMBXUj5ILmTAecE1JtGtKZD+?=
 =?iso-8859-1?Q?XphSXXVn1v4O9NfMp8bd1d7BXwhZfsdAOgndJXT8jUDhf/oQIjBsDwJHnS?=
 =?iso-8859-1?Q?uzQbsBuqRzRaLwbfAHKd8jTHaR+xytpUCHBY883FtU+8cTGM7BTMQNa7/w?=
 =?iso-8859-1?Q?OFD3/9QOAow4StyGgUR2rH9fgsyba6miSBdqcwnavbvIkXJxhgk4neLA1m?=
 =?iso-8859-1?Q?0g2piyoLiiq0rbYhFSBB1Z8T0grCwTKXq0wev8bp/Q3tSuC4QMslwlmd6o?=
 =?iso-8859-1?Q?9mmgqKvPztT1QrwUMoWG8on5kNLnwNciG4eVSmSpiUb25kGPuItevxyv9U?=
 =?iso-8859-1?Q?gT7g5/WY48NGe+7GUVmy7F2eNuIfrrYdN8gNe2Ulca5H1uUk4J+DqeuMUt?=
 =?iso-8859-1?Q?XMgysipGah19emF6nOsFbw3dItIyjQWwmQMCo4tM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CIWOS7HeGdcH0aJD7iIeK+oBmMJMF7dP4dShYpA5ZyoDJOIsyQNvNhzaHd?=
 =?iso-8859-1?Q?S93L+vz3y41zAEJ8bKG6jaQj/xrh216QOWIWpHbg4YNEfTg4kWp604lmxL?=
 =?iso-8859-1?Q?ndVC29/IV49FktJoGaWDoV+cqYc0o3Dz8pNRiwBuWPxzYQpz/uB3dOkAI+?=
 =?iso-8859-1?Q?IlTHW4Qz3EkUfQ9tYEdBQL3jTdpUj1ayasI32yQJkYJI5D9XrGI2jaxUTo?=
 =?iso-8859-1?Q?DabaJNyZ6bmo2rpe0jZ6ZrmVFUgenTVIQYWbIH9B1zojudoWvf18gRKhvB?=
 =?iso-8859-1?Q?gv+40jbx3E3KrBNZLc3WUH5htZN4qjY4OH7HYM9BG5jsevJM8K6ndAhMGW?=
 =?iso-8859-1?Q?E3qrKMgzM/gc7tAWI+lazIZCXsn99FFgkTWv/k+1ClZ70pqAh6E3S5r8cW?=
 =?iso-8859-1?Q?hoQeM5kWw2pHC3YajSu9rHga7lFycaQMM/0TsnDF/eRSFlIHVNJwHXzr21?=
 =?iso-8859-1?Q?nRKzq9G9LXZXtAz8iIBTpXcdZH+itkvsKxhQNTjFjEF3WQirBRD7E2xopp?=
 =?iso-8859-1?Q?P/B2k23Ia8T/IFrA/fSICw3o0Ze6Ukh+pmtH6ILu/p377nGgk0JJ9GjvTp?=
 =?iso-8859-1?Q?iHvkDJdhijBbQjj3TTo6fmgfII8mQgQbYd0ShMgPKBKqC48XA9GBXmbkxE?=
 =?iso-8859-1?Q?cLIMMSOtozB49ML+udVRyeY07piIU9Ln9w71HzR2Z+gHs54nPwJH7+tLBu?=
 =?iso-8859-1?Q?efCZlIRdWxhhjfySSVXTV13XawWm3naltjdc47mHTEDE4DCyDiPiIMzemk?=
 =?iso-8859-1?Q?IXGJ8EomuE/BRcFDrc8Uj21Xx9FCc6gi6zLt/c0sJEwfBvvz1ZgUWynHq4?=
 =?iso-8859-1?Q?v5INSO82lIbFxWuP8xn3IQ9O4R+zgqccOCpB5oJJS0+BvlrCsChzjcPn3A?=
 =?iso-8859-1?Q?O5gVbW4qMIJ/pDrBc7/I3hv+8pFReDBjWzps0IsQIzqVniqqZWa0lMWrKP?=
 =?iso-8859-1?Q?DVx3PUd25A0RekQviQ3CPXIuu9odyFBX1oCps3fFQL7+3hIndk20sol7pi?=
 =?iso-8859-1?Q?+DGGRRDy6F6lbM4TPWQVxaw+zA6mkm90lm5IjncsakTQdRmhDGqs5J84cs?=
 =?iso-8859-1?Q?Ppk7cWVLilYg1L6k0W9R/zQvmmgzVb8aX9kZkr8Fp0GLh/RYXYHWQJjQRm?=
 =?iso-8859-1?Q?axsCo9P2Zdely6b4bMIZDfQvPyOSQzxodEHTcp/1JVUdKDCz1YwKL8euOG?=
 =?iso-8859-1?Q?XTvAVPT2CrZxFWiU9O2uSdlufhwdM1T6wrh6Ot4D1lA6iKjoq3j7efyni5?=
 =?iso-8859-1?Q?aYS1nrhCXiPzL+OLZX2S4KgNKKmDcR+KLCX2Zudp5ASqWOTFmaQRbtOgbQ?=
 =?iso-8859-1?Q?ea0xnG2AZZVXTPKRmdq4nj7H9IK7REVhDqiU6KfhqGrgWzjCcJpuplq8Qe?=
 =?iso-8859-1?Q?CWHxzYqTwZmxd9tPJXtNP7wbj6EuLWlj8/MEAx2sEjVRzki7JeYxfWV29o?=
 =?iso-8859-1?Q?rRtB9M9Ybds5qrAFHak9SO5xsOJ8EZw46efNJW96kL2mWi3whJqR9e+bk6?=
 =?iso-8859-1?Q?N/U+1S1Hw0WSeQvekTWFfGNuOvhcVMbVMUdukkZjsStZMym8mVhEaPAveZ?=
 =?iso-8859-1?Q?KwMYI8367psSj4oa673DJa5aTuLOekoQOdJW6rogJfOEuROm8MJdaA9JA4?=
 =?iso-8859-1?Q?QNTfAP07drS5qaEH66ClE5LAek6se3xFSjfcT0qryXYkBWF0iFyZ2B1ar3?=
 =?iso-8859-1?Q?Gta/3Pyy7LexpzXjvl+GFuxDB30XYKTh5LJS8SfY+pr4cbjoba8h4h9ogg?=
 =?iso-8859-1?Q?bjIvtpIDn5beWgTYHKwy+45e6Ksrx4Vej+8fMgMSsLgVNpZxI4QgOrWTkM?=
 =?iso-8859-1?Q?owKVbMRi5g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab0fddc-81c3-4e8b-6e39-08de652e90d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:40.5692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wbk6GRVGkMctOypUpM8WIzUHzdg3r2+8xCEeMlTMacUU20obc7eV9Qazjsp+KP4Vly2pXDo67e+CPI56kNTOeHkzuFGKFbAd9V38luB/YIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RESET_CTRL and INTR_FORCE are write-only.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 02fa9b3c00..e20244de2c 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -342,7 +342,10 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offse=
t, unsigned size)=0A=
     uint64_t value;=0A=
 =0A=
     switch (addr) {=0A=
+    /* RAZ */=0A=
     case R_COMMAND_QUEUE_PORT:=0A=
+    case R_RESET_CTRL:=0A=
+    case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
     default:=0A=
-- =0A=
2.43.0=0A=

