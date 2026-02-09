Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B48E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNO0-0004dB-AG; Mon, 09 Feb 2026 04:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNy-0004bq-DW; Mon, 09 Feb 2026 04:16:50 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNv-0007Gs-0z; Mon, 09 Feb 2026 04:16:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AINkykvTkMqn4QmwSfu0xSgZ33XcMLAmRKP0pHlRKEYR15sXum4vo2Ez9dZ8rnti2yLr8vbi4szyoZYp+w1pgXexmAJrxc/jWvhXFmFQJViOHCF5h2pIJYvpZQm+4Nkgrwx9DeKAETqH9uScQG0nChyHh0kDBe6+Wo8Bg7Cpebr/vArub8BNR5Ay6HgtnRp/3178wne17lBLbhz7KrQvg+kjzz5cToRifGdrGKSUCL2WEM5AcljPhumVZN9bZazjz+9xr6BYGY/HLUZ/O1yIeu67aUFLnPQwlxbULAzA70LwHB7DvilmyFgFjjVM2ZSioo2pd0WjTARf27CfzbiIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyO4ssqSnSDTXv7LJaCuJ2pz4H93xth3tgo+x75II9A=;
 b=L1HhWGFGzHpuEDLvbDOvfkrjQ1Wz5rEze0FhKxeEf23UTQ1P1/hRUOBwa1Bgi+dHhWxFuR5wq+sWDUMESx8LqJLBwSH2FOx3HyVDi6zUZaBUd30kXo9P5kLqLH0AsWbLbck00o4EDQUylGtj0bpeivtRliOeIFlW9ww6SR2Z5kgDly4Wfi2gpI+q/C5tHSLVSUL4NywTqFNO4a7TPBhKjRlA43po2foCPgqPj2PnUJz5uyKzZOH0FGby+lGWhqpWFiZwyIlb14H2ZxGHSnmqsz5REyVKxmV8M46RCCVPbwbMxY7GIhLItzBKCAIsQb1NUU9c5DOGytXcBvdqCnzBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyO4ssqSnSDTXv7LJaCuJ2pz4H93xth3tgo+x75II9A=;
 b=VzMNSCRu4z+70NtS3VP9YC09nKOllCi08mnzer0DctJ4pZ9tG3RFnx5lHfSTbpVS8bBfAGHz5bsivaQ9gUna54tlXJsjv58Ck8a1kchbP87OUkLnootZ48TIQEIF+Kx/DoNZc+UDdEECzGpopRKGf9tr1cicNufNmD4X+zm0JxQLSRCQ6ygmZq7YGSHT9i5+9QLil6YKPum/Hm1OxXqwifcj9nKqUOIU90XhhOzhsaDi3tY6Qffr1jqwbDA75J6STnISY/nTcJ1JZ83za7Sx8OUqbS0gvFS4L/LYQ60Hxt7m9uobEJoTmNAR37tzwXmUvDnWxBk8C3rm1uW8S9ly4g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5250.apcprd06.prod.outlook.com (2603:1096:400:1fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:33 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>, Titus Rwantare <titusr@google.com>
Subject: [PATCH v4 02/20] hw/i3c: Add bus support
Thread-Topic: [PATCH v4 02/20] hw/i3c: Add bus support
Thread-Index: AQHcmaTIjKDMPP+yvkiJ7sfarXwh0w==
Date: Mon, 9 Feb 2026 09:16:33 +0000
Message-ID: <20260209091629.823457-3-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5250:EE_
x-ms-office365-filtering-correlation-id: 4b89d9b3-a8e8-4e74-1071-08de67bbeaf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sc3GukMOm6A8wppDsrpkjIJ3dF/emqFGZ+cmrfmNWfbqMFeJGqjwI3QE8D?=
 =?iso-8859-1?Q?icZ3uy8zyW4SUGar17BOPVhcNILduB2n1ciEe7o8+lL+An3DIIf8wIthr9?=
 =?iso-8859-1?Q?Pg5KE8pXlymLnQkt0qavaZxs5cqVnCpNbwIyHAExqyKKPmgBv8CNR7nwCg?=
 =?iso-8859-1?Q?WAZVzr66Y0H+uoCPLro1G1+nGg6WCm0RSn51iIGMQQVQdo73ddSdkVbtdw?=
 =?iso-8859-1?Q?rhIJ3wxI59ckdUo+gydP4kJ7dfHpO5/eownocbHAxgPCoiQaVAIT8I2IOs?=
 =?iso-8859-1?Q?GhLAtC/x1HiMRyPbt75cYKDh97adI+FIulvOQBWUmwfS3Ctu2vW2Wbgv2W?=
 =?iso-8859-1?Q?ZGmqiuqmTjVt8bSOarJvyMV0UKgMYs5NCN2znN1WbJp9ns0X1goE16Vz3M?=
 =?iso-8859-1?Q?MHC0unCY9gx1VjjDrXyuBOs6WlM4jDNL7v9NTmFa6nJJ/ubPBrWw+aM/NI?=
 =?iso-8859-1?Q?froO3+3cFc7u+xd8sk5+hP1+cjJPl8A2vH3GQNfL9y62vAzTZrO/SHlhZt?=
 =?iso-8859-1?Q?KrxcuoTdfFxbtQG3b88UwqX9RTBZjyxlAWf0R5X3w20Vgpqca94wAyGNlV?=
 =?iso-8859-1?Q?qWDPPa0UV2gHds3Yq2M3qO+tN+Dr74SPQEhYigeI2idgdZf+CgbIOBz5eS?=
 =?iso-8859-1?Q?lUR7kIy0EO759wFQw90JjCsEqNcEHU4tsgLAflGxpDHwgSYXNzWR2xdqrP?=
 =?iso-8859-1?Q?DQBMK3zZnicZ2GQhjtJ2qgsuHYCJNPOxWOp1ain6fGRNMkMK6RbIrqavI8?=
 =?iso-8859-1?Q?zgZi36RlslCCM5X+o/AFHFcIiGGipwUZDH/3wdhvTvWmcc2//sKw6ToHQz?=
 =?iso-8859-1?Q?I9O7B0UY9oPiEKClimI+x3JVEJCwMAtGsmAhq6253XfcUyw/UFD7stwm0E?=
 =?iso-8859-1?Q?YeQv1SzsvF7XZYPRV60ifDTritV+GSlryT1Mrt8toq2UEv8HTBX8GsdJIl?=
 =?iso-8859-1?Q?LuBwbLHGEsuChIKVvz6gJAYxR139tADqQYYvV5mVsEnJHxZzgKOesmju9A?=
 =?iso-8859-1?Q?q+QHz2rFgBEnFjNV3rfe9AsncJYB/UoBt0iHF+SdL09jhRcupriGjoXq3R?=
 =?iso-8859-1?Q?fUE/j5psYM9xxwuNUFacdzZYZHAOyVTaJOxGNR99xT8LEi0FIhAHNcLQs5?=
 =?iso-8859-1?Q?eJGDSwOBKSBiC+RE8zPDh5qO2gfsrHt5gjSnkaCsrmhyh2jEpbdOiiooxK?=
 =?iso-8859-1?Q?OzNIMsU6BhvkzwUSIEbsaymBjj9G+Hu77IlEhDG3/qtHexCU22vgUvHtf3?=
 =?iso-8859-1?Q?hxy0nRJk3ICtYpmdI59VcwNq62wBAbw86iUNC8jcBE9r/zUh/i+z1NJ3KC?=
 =?iso-8859-1?Q?FaW4Jz3e/Rp/kRHMyRw4p64/4RB65QrRf9GyPWSfuOXPVEGXDxCtJGU5/p?=
 =?iso-8859-1?Q?0S+0Fjd2lNS8hcVutQo9pzaAMcmDHhFMfg1cGhaT8JhHGf5yiyY//uoy73?=
 =?iso-8859-1?Q?mZ+cLEDLxN9yhn7BPGZuY7JYrtND6sOi+slfTDw3LgOKs2dVdpc6A5mHVH?=
 =?iso-8859-1?Q?uLGNeFfXIkmJv9dP2nhL0Qr0vCpVl7iMoU6zHy53eRtCYeqQ+Rn6JdYQd+?=
 =?iso-8859-1?Q?ZXgmUQdGkVWuHC1IIb+C3ChcucicITDAVzfyba3Kq7o0db6oB85V/XDJ4Q?=
 =?iso-8859-1?Q?czUvZtsqLg0I+xPVo8kXMwkgYTjYM8M59DpxLE2vJm8FYcssK7Xeo+pmgx?=
 =?iso-8859-1?Q?oRpBcmEgjKigGK87cKbdkTIfLJ+t6HbixC8YY6Gb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zpEn20MJQQc0VIMj7S/LrG1B4cR+D786YLv2cbFfzDaKGGd3AdftyU0cr3?=
 =?iso-8859-1?Q?HvgRs4xwGcWN0oUt20Y3onrZNV+gAbbJEgOkWUtcGUtImOknt17JbmXmsE?=
 =?iso-8859-1?Q?WpxtJKzyaCFiLN/q/2jdw1I51+dRCSwCcdPR5j/QphXF98qhXPI7X3TSv7?=
 =?iso-8859-1?Q?qISA9juHJoKbqew8RtG0GY3SewVDwldjJw2XSOFZEhFOLESG3Lzo2BFcaq?=
 =?iso-8859-1?Q?v9Pxn8TLWXQhPOP+YpH/c+cgq/sHW5N/vmxLeqFAA6EBKx0vLMDhgKASAX?=
 =?iso-8859-1?Q?Nw+2srF+m5f3YDgqUxElE2DA961VL6kfyZByqTRy+5d2Q9iibX7+0/cJvE?=
 =?iso-8859-1?Q?aP5sjygPG0gKb7ZkvmQmf4c6MsdgTixsRXJ3inC1cDCLltRPVXaZcxYUA7?=
 =?iso-8859-1?Q?lgPQVkeVdEYQPQMA68Cs7tHKA4w5d9iUpRSD0pxhf6ovBClWApCQ/1qqdK?=
 =?iso-8859-1?Q?IfHWYa2T6/vVPnh+JKvX3Jnl+j9pQX5Z4KiwTUCpGjQzgNmEYdz/YRE/CM?=
 =?iso-8859-1?Q?IdMHVumGk6e8m9iKfTepTnf/12uly95c7SsTOscBzjnxxV6fxgGZCJ6k2k?=
 =?iso-8859-1?Q?a8xfdz2SMVdyvd040j4ae18Pb8u9Vu2VTg3G39XtRoeZy0WwZSxyXrBVf+?=
 =?iso-8859-1?Q?m0qUwQhhTSZaLo1ZywzXshMJ5UOgTY3Vrd+otxKzFaaJSJDURDbBc87PXC?=
 =?iso-8859-1?Q?z5cdpNP+Z/hqJJXkFm094O1XyS4jsTrFmsyvVQaGdIKintGZrUbsptQ6Ph?=
 =?iso-8859-1?Q?hNz8RFPMZjzmMOM6oa+LqmIeOZDM2h2VrKt01+XE+r6LTJae5Il9tHJS68?=
 =?iso-8859-1?Q?6QJWeJio+l3BJ/8uKv3pps3CvUkTWLLP7z+/UBI1SVTrPUyHkGlXNzdP8M?=
 =?iso-8859-1?Q?4w6V34emD6Kp4LSmFvcvv+MejKTwH+AxJ64KfxeV3GsGDuFCUetY+mGCjl?=
 =?iso-8859-1?Q?WuGzQa4xtAtmbAHFLPtE4P3jWszhH4KFnJD4EAHBPLJUMUUvDMT/U7IfMX?=
 =?iso-8859-1?Q?IFgo6KRzwtMYfg445yfcyePLcU2MJJWDrNxSVYDHXw/c0NEKImYNP69t5w?=
 =?iso-8859-1?Q?DkbFE3LSvo/rCeDcT/ijDlttyNlbSjOUZSTpbr5EieEd/89FSa8FAuu80v?=
 =?iso-8859-1?Q?j3OwgBwhveOHKI8mIruzDU168nJlkOCsXFbTY8ZsfqUVtEh+Peqr++mbPy?=
 =?iso-8859-1?Q?hgeXW0gWJzjSh0xuaj94+Dc0Zin9SaCB4v2nfjFFm9fC/gfFbxVdo6REi/?=
 =?iso-8859-1?Q?QFH7ofp3vp4oXxOVmxHZQTVrSvZlmGuFE9RWoPWGIUAbRUUVUJk526Tvxg?=
 =?iso-8859-1?Q?8F1RSo0OXQFnD42PWExCHeqMKwVfCXo/4E354rNI5SbqeAl966syGfz8/P?=
 =?iso-8859-1?Q?hMvuLvImihFxySQe9o+4To/iPLc1P/sgy1CNMb2fvrJQatvJPxwBgFnMy0?=
 =?iso-8859-1?Q?CxmRDV/7l51Qm3zahZOwTFF/5oz6Jx5TYRtLmX0Qwn1kNwsGiGFRycyOQI?=
 =?iso-8859-1?Q?TViox9teu2jROxhxjXRuooqioQ5i15sgHUZ6p269w3VhYgvD3ieTHjaHkG?=
 =?iso-8859-1?Q?YNv6OhPhALSNj18jMlsCB+VuV2ul1XVyeFIfqESKlrXA1TFQhVFGQPgcAm?=
 =?iso-8859-1?Q?6oZhoE8k1Mnr98255AteTttixhpGsJYR8uAVue4Y2sBHoF01nX4d5PjmMe?=
 =?iso-8859-1?Q?6kb1e1djhn4D2XW+47HUiqa/hncIbyU7kgWsdBIVQ3DFWIgVxOJpzF6JpA?=
 =?iso-8859-1?Q?VFBSaWspdHOXwsD2pelfMn/pqevoVvu9f3k39+6L3StiynsMLWjgITI/Cp?=
 =?iso-8859-1?Q?5SyMznw6aw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b89d9b3-a8e8-4e74-1071-08de67bbeaf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:33.1077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +3FrIBSYxeQdDkeXsqqQ3QOdm3PPmbr9K5N888PptOYDFAZFtOvnNggVQxDUWmgHbumqJh1GXZUVFxkDfXSH8HD0FKEZquLH4hNlWIsfjjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5250
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Adds an I3C bus and a target class.=0A=
The bus supports:=0A=
- I3C data transmission and reception=0A=
- CCCs (including ENTDAA)=0A=
- IBIs=0A=
- legacy I2C transactions=0A=
=0A=
General usage of the bus is similar to I2C. Users are expected to=0A=
initialize a bus via i3c_init_bus, and use the bus returned from the=0A=
init function to do transactions on the bus.=0A=
=0A=
In order to handle IBIs, the controller provides callbacks to handle=0A=
receiving an IBI from a target, receiving (optional) additional IBI=0A=
bytes from a target, and handling when a target is done with its IBI.=0A=
=0A=
Similarly, target creation is done via i3c_target_create_simple and=0A=
users use the provided I3CTarget to handle transactions.=0A=
The target has functions provided that it can use to invoke an IBI and=0A=
send additional bytes.=0A=
=0A=
Along with the send, recv, and event callbacks that are expected of an=0A=
I3C target, which are similar to I2C, there is a separate callback for=0A=
CCC handling.=0A=
This is to help encapsulate CCC handling and keep it separate from=0A=
target-specific read/write functionality.=0A=
=0A=
To avoid repition for required CCCs among I3C targets, there is some=0A=
class-level CCC handling added. The CCC is then passed to the target in=0A=
case it needs to handle it in some way.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/i3c.h | 277 ++++++++++++++++++=0A=
 hw/i3c/core.c        | 652 +++++++++++++++++++++++++++++++++++++++++++=0A=
 hw/i3c/meson.build   |   1 +=0A=
 hw/i3c/trace-events  |  16 ++=0A=
 4 files changed, 946 insertions(+)=0A=
 create mode 100644 include/hw/i3c/i3c.h=0A=
 create mode 100644 hw/i3c/core.c=0A=
=0A=
diff --git a/include/hw/i3c/i3c.h b/include/hw/i3c/i3c.h=0A=
new file mode 100644=0A=
index 0000000000..455c2a4a4f=0A=
--- /dev/null=0A=
+++ b/include/hw/i3c/i3c.h=0A=
@@ -0,0 +1,277 @@=0A=
+/*=0A=
+ * QEMU I3C bus interface.=0A=
+ *=0A=
+ * Copyright 2025 Google LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef QEMU_INCLUDE_HW_I3C_I3C_H_=0A=
+#define QEMU_INCLUDE_HW_I3C_I3C_H_=0A=
+=0A=
+#include "hw/core/qdev.h"=0A=
+#include "qom/object.h"=0A=
+#include "hw/i2c/i2c.h"=0A=
+=0A=
+#define TYPE_I3C_TARGET "i3c-target"=0A=
+OBJECT_DECLARE_TYPE(I3CTarget, I3CTargetClass, I3C_TARGET)=0A=
+=0A=
+typedef enum I3CEvent {=0A=
+    I3C_START_RECV,=0A=
+    I3C_START_SEND,=0A=
+    I3C_STOP,=0A=
+    I3C_NACK,=0A=
+} I3CEvent;=0A=
+=0A=
+typedef enum I3CCCC {=0A=
+    /* Broadcast CCCs */=0A=
+    I3C_CCC_ENEC      =3D 0x00,=0A=
+    I3C_CCC_DISEC     =3D 0x01,=0A=
+    I3C_CCC_ENTAS0    =3D 0x02,=0A=
+    I3C_CCC_ENTAS1    =3D 0x03,=0A=
+    I3C_CCC_ENTAS2    =3D 0x04,=0A=
+    I3C_CCC_ENTAS3    =3D 0x05,=0A=
+    I3C_CCC_RSTDAA    =3D 0x06,=0A=
+    I3C_CCC_ENTDAA    =3D 0x07,=0A=
+    I3C_CCC_DEFTGTS   =3D 0x08,=0A=
+    I3C_CCC_SETMWL    =3D 0x09,=0A=
+    I3C_CCC_SETMRL    =3D 0x0a,=0A=
+    I3C_CCC_ENTTM     =3D 0x0b,=0A=
+    I3C_CCC_SETBUSCON =3D 0x0c,=0A=
+    I3C_CCC_ENDXFER   =3D 0x12,=0A=
+    I3C_CCC_ENTHDR0   =3D 0x20,=0A=
+    I3C_CCC_ENTHDR1   =3D 0x21,=0A=
+    I3C_CCC_ENTHDR2   =3D 0x22,=0A=
+    I3C_CCC_ENTHDR3   =3D 0x23,=0A=
+    I3C_CCC_ENTHDR4   =3D 0x24,=0A=
+    I3C_CCC_ENTHDR5   =3D 0x25,=0A=
+    I3C_CCC_ENTHDR6   =3D 0x26,=0A=
+    I3C_CCC_ENTHDR7   =3D 0x27,=0A=
+    I3C_CCC_SETXTIME  =3D 0x28,=0A=
+    I3C_CCC_SETAASA   =3D 0x29,=0A=
+    I3C_CCC_RSTACT    =3D 0x2a,=0A=
+    I3C_CCC_DEFGRPA   =3D 0x2b,=0A=
+    I3C_CCC_RSTGRPA   =3D 0x2c,=0A=
+    I3C_CCC_MLANE     =3D 0x2d,=0A=
+    /* Direct CCCs */=0A=
+    I3C_CCCD_ENEC       =3D 0x80,=0A=
+    I3C_CCCD_DISEC      =3D 0x81,=0A=
+    I3C_CCCD_ENTAS0     =3D 0x82,=0A=
+    I3C_CCCD_ENTAS1     =3D 0x83,=0A=
+    I3C_CCCD_ENTAS2     =3D 0x84,=0A=
+    I3C_CCCD_ENTAS3     =3D 0x85,=0A=
+    I3C_CCCD_SETDASA    =3D 0x87,=0A=
+    I3C_CCCD_SETNEWDA   =3D 0x88,=0A=
+    I3C_CCCD_SETMWL     =3D 0x89,=0A=
+    I3C_CCCD_SETMRL     =3D 0x8a,=0A=
+    I3C_CCCD_GETMWL     =3D 0x8b,=0A=
+    I3C_CCCD_GETMRL     =3D 0x8c,=0A=
+    I3C_CCCD_GETPID     =3D 0x8d,=0A=
+    I3C_CCCD_GETBCR     =3D 0x8e,=0A=
+    I3C_CCCD_GETDCR     =3D 0x8f,=0A=
+    I3C_CCCD_GETSTATUS  =3D 0x90,=0A=
+    I3C_CCCD_GETACCCR   =3D 0x91,=0A=
+    I3C_CCCD_ENDXFER    =3D 0x92,=0A=
+    I3C_CCCD_SETBRGTGT  =3D 0x93,=0A=
+    I3C_CCCD_GETMXDS    =3D 0x94,=0A=
+    I3C_CCCD_GETCAPS    =3D 0x95,=0A=
+    I3C_CCCD_SETROUTE   =3D 0x96,=0A=
+    I3C_CCCD_SETXTIME   =3D 0x98,=0A=
+    I3C_CCCD_GETXTIME   =3D 0x99,=0A=
+    I3C_CCCD_RSTACT     =3D 0x9a,=0A=
+    I3C_CCCD_SETGRPA    =3D 0x9b,=0A=
+    I3C_CCCD_RSTGRPA    =3D 0x9c,=0A=
+    I3C_CCCD_MLANE      =3D 0x9d,=0A=
+} I3CCCC;=0A=
+=0A=
+#define CCC_IS_DIRECT(_ccc) (_ccc & 0x80)=0A=
+=0A=
+#define I3C_BROADCAST 0x7e=0A=
+#define I3C_HJ_ADDR 0x02=0A=
+#define I3C_ENTDAA_SIZE 8=0A=
+=0A=
+struct I3CTargetClass {=0A=
+    DeviceClass parent;=0A=
+=0A=
+    /*=0A=
+     * Controller to target. Returns 0 for success, non-zero for NAK or ot=
her=0A=
+     * error.=0A=
+     */=0A=
+    int (*send)(I3CTarget *s, const uint8_t *data, uint32_t num_to_send,=
=0A=
+                uint32_t *num_sent);=0A=
+    /*=0A=
+     * Target to controller. I3C targets are able to terminate reads early=
, so=0A=
+     * this returns the number of bytes read from the target.=0A=
+     */=0A=
+    uint32_t (*recv)(I3CTarget *s, uint8_t *data, uint32_t num_to_read);=
=0A=
+    /* Notify the target of a bus state change. */=0A=
+    int (*event)(I3CTarget *s, enum I3CEvent event);=0A=
+    /*=0A=
+     * Handle a read CCC transmitted from a controller.=0A=
+     * CCCs are I3C commands that I3C targets support.=0A=
+     * The target can NACK the CCC if it does not support it.=0A=
+     */=0A=
+    int (*handle_ccc_read)(I3CTarget *s, uint8_t *data, uint32_t num_to_re=
ad,=0A=
+                           uint32_t *num_read);=0A=
+    /*=0A=
+     * Handle a write CCC transmitted from a controller.=0A=
+     * CCCs are I3C commands that I3C targets support.=0A=
+     * The target can NACK the CCC if it does not support it.=0A=
+     */=0A=
+    int (*handle_ccc_write)(I3CTarget *s, const uint8_t *data,=0A=
+                            uint32_t num_to_send, uint32_t *num_sent);=0A=
+=0A=
+    /*=0A=
+     * Matches and adds the candidate if the address matches the candidate=
's=0A=
+     * address.=0A=
+     * Returns true if the address matched, or if this was a broadcast, an=
d=0A=
+     * updates the device list. Otherwise returns false.=0A=
+     */=0A=
+    bool (*target_match)(I3CTarget *candidate, uint8_t address, bool is_re=
ad,=0A=
+                         bool broadcast, bool in_entdaa);=0A=
+};=0A=
+=0A=
+struct I3CTarget {=0A=
+    DeviceState qdev;=0A=
+=0A=
+    uint8_t address;=0A=
+    uint8_t static_address;=0A=
+    uint8_t dcr;=0A=
+    uint8_t bcr;=0A=
+    uint64_t pid;=0A=
+=0A=
+    /* CCC State tracking. */=0A=
+    I3CCCC curr_ccc;=0A=
+    uint8_t ccc_byte_offset;=0A=
+    bool in_ccc;=0A=
+    bool in_test_mode;=0A=
+};=0A=
+=0A=
+struct I3CNode {=0A=
+    I3CTarget *target;=0A=
+    QLIST_ENTRY(I3CNode) next;=0A=
+};=0A=
+=0A=
+typedef struct I3CNode I3CNode;=0A=
+=0A=
+typedef QLIST_HEAD(I3CNodeList, I3CNode) I3CNodeList;=0A=
+=0A=
+#define TYPE_I3C_BUS "i3c-bus"=0A=
+OBJECT_DECLARE_TYPE(I3CBus, I3CBusClass, I3C_BUS)=0A=
+=0A=
+struct I3CBus {=0A=
+    BusState qbus;=0A=
+=0A=
+    /* Legacy I2C. */=0A=
+    I2CBus *i2c_bus;=0A=
+=0A=
+    I3CNodeList current_devs;=0A=
+    bool broadcast;=0A=
+    uint8_t ccc;=0A=
+    bool in_ccc;=0A=
+    bool in_entdaa;=0A=
+    uint8_t saved_address;=0A=
+};=0A=
+=0A=
+struct I3CBusClass {=0A=
+    DeviceClass parent;=0A=
+=0A=
+    /* Handle an incoming IBI request from a target */=0A=
+    int (*ibi_handle) (I3CBus *bus, uint8_t addr, bool is_recv);=0A=
+    /* Receive data from an IBI request */=0A=
+    int (*ibi_recv) (I3CBus *bus, uint8_t data);=0A=
+    /* Do anything that needs to be done, since the IBI is finished. */=0A=
+    int (*ibi_finish) (I3CBus *bus);=0A=
+};=0A=
+=0A=
+I3CBus *i3c_init_bus(DeviceState *parent, const char *name);=0A=
+I3CBus *i3c_init_bus_type(const char *type, DeviceState *parent,=0A=
+                          const char *name);=0A=
+void i3c_set_target_address(I3CTarget *dev, uint8_t address);=0A=
+bool i3c_bus_busy(I3CBus *bus);=0A=
+=0A=
+/*=0A=
+ * Start a transfer on an I3C bus.=0A=
+ * If is_recv is known at compile-time (i.e. a device will always be sendi=
ng or=0A=
+ * will always be receiving at a certain point), prefer to use i3c_start_r=
ecv or=0A=
+ * i3c_start_send instead.=0A=
+ *=0A=
+ * Returns 0 on success, non-zero on an error.=0A=
+ */=0A=
+int i3c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv);=0A=
+=0A=
+/*=0A=
+ * Start a receive transfer on an I3C bus.=0A=
+ *=0A=
+ * Returns 0 on success, non-zero on an error=0A=
+ */=0A=
+int i3c_start_recv(I3CBus *bus, uint8_t address);=0A=
+=0A=
+/*=0A=
+ * Start a send transfer on an I3C bus.=0A=
+ *=0A=
+ * Returns 0 on success, non-zero on an error=0A=
+ */=0A=
+int i3c_start_send(I3CBus *bus, uint8_t address);=0A=
+=0A=
+void i3c_end_transfer(I3CBus *bus);=0A=
+void i3c_nack(I3CBus *bus);=0A=
+int i3c_send_byte(I3CBus *bus, uint8_t data);=0A=
+int i3c_send(I3CBus *bus, const uint8_t *data, uint32_t num_to_send,=0A=
+             uint32_t *num_sent);=0A=
+/*=0A=
+ * I3C receives can only NACK on a CCC. The target should NACK a CCC it do=
es not=0A=
+ * support.=0A=
+ */=0A=
+int i3c_recv_byte(I3CBus *bus, uint8_t *data);=0A=
+int i3c_recv(I3CBus *bus, uint8_t *data, uint32_t num_to_read,=0A=
+             uint32_t *num_read);=0A=
+bool i3c_scan_bus(I3CBus *bus, uint8_t address, enum I3CEvent event);=0A=
+int i3c_do_entdaa(I3CBus *bus, uint8_t address, uint64_t *pid, uint8_t *bc=
r,=0A=
+                  uint8_t *dcr);=0A=
+int i3c_start_device_transfer(I3CTarget *dev, int send_length);=0A=
+bool i3c_target_match_and_add(I3CBus *bus, I3CTarget *target, uint8_t addr=
ess,=0A=
+                             enum I3CEvent event);=0A=
+int i3c_target_send_ibi(I3CTarget *t, uint8_t addr, bool is_recv);=0A=
+int i3c_target_send_ibi_bytes(I3CTarget *t, uint8_t data);=0A=
+int i3c_target_ibi_finish(I3CTarget *t, uint8_t data);=0A=
+=0A=
+/*=0A=
+ * Legacy I2C functions.=0A=
+ *=0A=
+ * These are wrapper for I2C functions that take in an I3C bus instead of =
an I2C=0A=
+ * bus. Internally they use the I2C bus (and devices attached to it) that'=
s a=0A=
+ * part of the I3C bus=0A=
+ */=0A=
+void legacy_i2c_nack(I3CBus *bus);=0A=
+uint8_t legacy_i2c_recv(I3CBus *bus);=0A=
+int legacy_i2c_send(I3CBus *bus, uint8_t data);=0A=
+int legacy_i2c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv);=
=0A=
+int legacy_i2c_start_recv(I3CBus *bus, uint8_t address);=0A=
+int legacy_i2c_start_send(I3CBus *bus, uint8_t address);=0A=
+void legacy_i2c_end_transfer(I3CBus *bus);=0A=
+I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,=
=0A=
+                                          uint8_t addr);=0A=
+=0A=
+/**=0A=
+ * Create an I3C Target.=0A=
+ *=0A=
+ * The target returned from this function still needs to be realized.=0A=
+ */=0A=
+I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,=0A=
+                          uint8_t bcr, uint64_t pid);=0A=
+=0A=
+/**=0A=
+ * Create and realize an I3C target.=0A=
+ *=0A=
+ * Create the target, initialize it, put it on the specified I3C bus, and=
=0A=
+ * realize it.=0A=
+ */=0A=
+I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name,=0A=
+                                    uint8_t addr, uint8_t dcr, uint8_t bcr=
,=0A=
+                                    uint64_t pid);=0A=
+=0A=
+/* Realize and drop the reference count on an I3C target. */=0A=
+bool i3c_target_realize_and_unref(I3CTarget *dev, I3CBus *bus, Error **err=
p);=0A=
+=0A=
+#endif  /* QEMU_INCLUDE_HW_I3C_I3C_H_ */=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
new file mode 100644=0A=
index 0000000000..fb4bfe5aec=0A=
--- /dev/null=0A=
+++ b/hw/i3c/core.c=0A=
@@ -0,0 +1,652 @@=0A=
+/*=0A=
+ * QEMU I3C bus interface.=0A=
+ *=0A=
+ * Copyright 2025 Google LLC=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qapi/error.h"=0A=
+#include "trace.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+=0A=
+/*=0A=
+ * In test mode (enabled by ENTTM CCC) we're supposed to send a random PID=
=0A=
+ * during ENTDAA, so we'll just send "QEMU".=0A=
+ */=0A=
+#define TEST_MODE_PROVISIONED_ID 0x0000554d4551ULL=0A=
+=0A=
+static const Property i3c_props[] =3D {=0A=
+    DEFINE_PROP_UINT8("static-address", struct I3CTarget, static_address, =
0),=0A=
+    DEFINE_PROP_UINT8("dcr", struct I3CTarget, dcr, 0),=0A=
+    DEFINE_PROP_UINT8("bcr", struct I3CTarget, bcr, 0),=0A=
+    DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),=0A=
+};=0A=
+=0A=
+static const TypeInfo i3c_bus_info =3D {=0A=
+    .name =3D TYPE_I3C_BUS,=0A=
+    .parent =3D TYPE_BUS,=0A=
+    .instance_size =3D sizeof(I3CBus),=0A=
+    .class_size =3D sizeof(I3CBusClass),=0A=
+};=0A=
+=0A=
+I3CBus *i3c_init_bus(DeviceState *parent, const char *name)=0A=
+{=0A=
+    return i3c_init_bus_type(TYPE_I3C_BUS, parent, name);=0A=
+}=0A=
+=0A=
+I3CBus *i3c_init_bus_type(const char *type, DeviceState *parent,=0A=
+                          const char *name)=0A=
+{=0A=
+    I3CBus *bus;=0A=
+=0A=
+    bus =3D I3C_BUS(qbus_new(type, parent, name));=0A=
+    QLIST_INIT(&bus->current_devs);=0A=
+    bus->broadcast =3D false;=0A=
+    bus->in_entdaa =3D false;=0A=
+    bus->in_ccc =3D false;=0A=
+=0A=
+    /* I2C init. */=0A=
+    g_autofree gchar *i2c_bus_name =3D g_strdup_printf("%s-legacy-i2c", na=
me);=0A=
+    bus->i2c_bus =3D i2c_init_bus(parent, i2c_bus_name);=0A=
+=0A=
+    return bus;=0A=
+}=0A=
+=0A=
+bool i3c_bus_busy(I3CBus *bus)=0A=
+{=0A=
+    return !QLIST_EMPTY(&bus->current_devs);=0A=
+}=0A=
+=0A=
+static bool i3c_target_match(I3CTarget *candidate, uint8_t address,=0A=
+                             bool is_recv, bool broadcast, bool in_entdaa)=
=0A=
+{=0A=
+    /* Once a target has a dynamic address, it only responds to that. */=
=0A=
+    uint8_t targ_addr =3D candidate->address ? candidate->address :=0A=
+                                             candidate->static_address;=0A=
+=0A=
+    if (in_entdaa) {=0A=
+        if (address !=3D I3C_BROADCAST) {=0A=
+            g_autofree char *path =3D=0A=
+                object_get_canonical_path(OBJECT(candidate));=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: I3C Address 0x%.2x sent du=
ring "=0A=
+                          "ENTDAA instead of a broadcast address\n",=0A=
+                          path, address);=0A=
+            return false;=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * Targets should only ACK ENTDAA broadcasts if they have no dynam=
ic=0A=
+         * address.=0A=
+         */=0A=
+        return candidate->address =3D=3D 0;=0A=
+    }=0A=
+=0A=
+    /* Return if our addresses match, or if it's a broadcast. */=0A=
+    return targ_addr =3D=3D address || broadcast;=0A=
+}=0A=
+=0A=
+bool i3c_target_match_and_add(I3CBus *bus, I3CTarget *target, uint8_t addr=
ess,=0A=
+                              enum I3CEvent event)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(target);=0A=
+    bool matched =3D tc->target_match(target, address, event =3D=3D I3C_ST=
ART_RECV,=0A=
+                                    bus->broadcast, bus->in_entdaa);=0A=
+=0A=
+    if (matched) {=0A=
+        I3CNode *node =3D g_new(struct I3CNode, 1);=0A=
+        node->target =3D target;=0A=
+        QLIST_INSERT_HEAD(&bus->current_devs, node, next);=0A=
+    }=0A=
+    return matched;=0A=
+}=0A=
+=0A=
+bool i3c_scan_bus(I3CBus *bus, uint8_t address, enum I3CEvent event)=0A=
+{=0A=
+    BusChild *child;=0A=
+    I3CNode *node, *next;=0A=
+=0A=
+    /* Clear out any devices from a previous (re-)START. */=0A=
+    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {=0A=
+        QLIST_REMOVE(node, next);=0A=
+        g_free(node);=0A=
+    }=0A=
+=0A=
+    QTAILQ_FOREACH(child, &bus->qbus.children, sibling) {=0A=
+        DeviceState *qdev =3D child->child;=0A=
+        I3CTarget *target =3D I3C_TARGET(qdev);=0A=
+=0A=
+        if (i3c_target_match_and_add(bus, target, address, event)) {=0A=
+            return true;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* No one on the bus could respond. */=0A=
+    return false;=0A=
+}=0A=
+=0A=
+/* Class-level event handling, since we do some CCCs at the class level. *=
/=0A=
+static int i3c_target_event(I3CTarget *t, enum I3CEvent event)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+    trace_i3c_target_event(t->address, event);=0A=
+=0A=
+    if (event =3D=3D I3C_STOP) {=0A=
+        t->curr_ccc =3D 0;=0A=
+        t->ccc_byte_offset =3D 0;=0A=
+        t->in_ccc =3D false;=0A=
+    }=0A=
+    return tc->event(t, event);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Sends a START or repeated START and the address for an I3C transaction.=
=0A=
+ *=0A=
+ * This function returns 0 if a device on the bus was able to respond to t=
he=0A=
+ * address, and non-zero otherwise.=0A=
+ * A non-zero return represents a NACK.=0A=
+ */=0A=
+static int i3c_do_start_transfer(I3CBus *bus, uint8_t address,=0A=
+                                 enum I3CEvent event)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CNode *node;=0A=
+=0A=
+    if (address =3D=3D I3C_BROADCAST) {=0A=
+        bus->broadcast =3D true;=0A=
+        /* If we're not in ENTDAA, a broadcast is the start of a new CCC. =
*/=0A=
+        if (!bus->in_entdaa) {=0A=
+            bus->in_ccc =3D false;=0A=
+        }=0A=
+    } else {=0A=
+        bus->broadcast =3D false;=0A=
+    }=0A=
+=0A=
+    /* No one responded to the address, NACK it. */=0A=
+    if (!i3c_scan_bus(bus, address, event)) {=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    QLIST_FOREACH(node, &bus->current_devs, next) {=0A=
+        I3CTarget *t =3D node->target;=0A=
+=0A=
+        tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+        if (tc->event) {=0A=
+            int rv =3D i3c_target_event(t, event);=0A=
+            if (rv && !bus->broadcast) {=0A=
+                return rv;=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+int i3c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv)=0A=
+{=0A=
+    trace_i3c_start_transfer(address, is_recv);=0A=
+    return i3c_do_start_transfer(bus, address, is_recv=0A=
+                                               ? I3C_START_RECV=0A=
+                                               : I3C_START_SEND);=0A=
+}=0A=
+=0A=
+int i3c_start_recv(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_i3c_start_transfer(address, true);=0A=
+    return i3c_do_start_transfer(bus, address, I3C_START_RECV);=0A=
+}=0A=
+=0A=
+int i3c_start_send(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_i3c_start_transfer(address, false);=0A=
+    return i3c_do_start_transfer(bus, address, I3C_START_SEND);=0A=
+}=0A=
+=0A=
+void i3c_end_transfer(I3CBus *bus)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CNode *node, *next;=0A=
+=0A=
+    trace_i3c_end_transfer();=0A=
+=0A=
+    /*=0A=
+     * If we're in ENTDAA, we need to notify all devices when ENTDAA is do=
ne.=0A=
+     * This is because everyone initially participates due to the broadcas=
t,=0A=
+     * but gradually drops out as they get assigned addresses.=0A=
+     * Since the current_devs list only stores who's currently participati=
ng,=0A=
+     * and not everyone who previously participated, we send the STOP to a=
ll=0A=
+     * children.=0A=
+     */=0A=
+    if (bus->in_entdaa) {=0A=
+        BusChild *child;=0A=
+=0A=
+        QTAILQ_FOREACH(child, &bus->qbus.children, sibling) {=0A=
+            DeviceState *qdev =3D child->child;=0A=
+            I3CTarget *t =3D I3C_TARGET(qdev);=0A=
+            tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+            if (tc->event) {=0A=
+                i3c_target_event(t, I3C_STOP);=0A=
+            }=0A=
+        }=0A=
+    } else {=0A=
+        QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {=0A=
+            I3CTarget *t =3D node->target;=0A=
+            tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+            if (tc->event) {=0A=
+                i3c_target_event(t, I3C_STOP);=0A=
+            }=0A=
+            QLIST_REMOVE(node, next);=0A=
+            g_free(node);=0A=
+        }=0A=
+    }=0A=
+    bus->broadcast =3D false;=0A=
+    bus->in_entdaa =3D false;=0A=
+    bus->in_ccc =3D false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Any CCCs that are universal across all I3C devices should be handled he=
re.=0A=
+ * Once they're handled, we pass the CCC up to the I3C target to do anythi=
ng=0A=
+ * else it may want with the bytes.=0A=
+ */=0A=
+static int i3c_target_handle_ccc_write(I3CTarget *t, const uint8_t *data,=
=0A=
+                                       uint32_t num_to_send, uint32_t *num=
_sent)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+    *num_sent =3D 0;=0A=
+=0A=
+    /* Is this the start of a new CCC? */=0A=
+    if (!t->in_ccc) {=0A=
+        t->curr_ccc =3D *data;=0A=
+        t->in_ccc =3D true;=0A=
+        *num_sent =3D 1;=0A=
+        trace_i3c_target_handle_ccc(t->address, t->curr_ccc);=0A=
+    }=0A=
+=0A=
+    switch (t->curr_ccc) {=0A=
+    case I3C_CCC_ENTDAA:=0A=
+        /*=0A=
+         * This is the last byte of ENTDAA, the controller is assigning us=
 an=0A=
+         * address.=0A=
+         */=0A=
+        if (t->ccc_byte_offset =3D=3D 8) {=0A=
+            t->address =3D *data;=0A=
+            t->in_ccc =3D false;=0A=
+            t->curr_ccc =3D 0;=0A=
+            t->ccc_byte_offset =3D 0;=0A=
+            *num_sent =3D 1;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCCD_SETDASA:=0A=
+        t->address =3D t->static_address;=0A=
+        break;=0A=
+    case I3C_CCC_SETAASA:=0A=
+        t->address =3D t->static_address;=0A=
+        break;=0A=
+    case I3C_CCC_RSTDAA:=0A=
+        t->address =3D 0;=0A=
+        break;=0A=
+    case I3C_CCCD_SETNEWDA:=0A=
+        /* If this isn't the CCC byte, it's our new address. */=0A=
+        if (*num_sent =3D=3D 0) {=0A=
+            t->address =3D *data;=0A=
+            *num_sent =3D 1;=0A=
+        }=0A=
+        break;=0A=
+    case I3C_CCC_ENTTM:=0A=
+        /*=0A=
+         * If there are still more to look at, the next byte is the test m=
ode=0A=
+         * byte.=0A=
+         */=0A=
+        if (*num_sent !=3D num_to_send) {=0A=
+            /* Enter test mode if the byte is non-zero. Otherwise exit. */=
=0A=
+            t->in_test_mode =3D !!data[*num_sent];=0A=
+            ++*num_sent;=0A=
+        }=0A=
+        break;=0A=
+    /* Ignore other CCCs it's better to handle on a device-by-device basis=
. */=0A=
+    default:=0A=
+        break;=0A=
+    }=0A=
+    return tc->handle_ccc_write(t, data, num_to_send, num_sent);=0A=
+}=0A=
+=0A=
+int i3c_send_byte(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    /*=0A=
+     * Ignored, the caller can determine how many were sent based on if th=
is was=0A=
+     * ACKed/NACKed.=0A=
+     */=0A=
+    uint32_t num_sent;=0A=
+    return i3c_send(bus, &data, 1, &num_sent);=0A=
+}=0A=
+=0A=
+int i3c_send(I3CBus *bus, const uint8_t *data, uint32_t num_to_send,=0A=
+             uint32_t *num_sent)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CTarget *t;=0A=
+    I3CNode *node;=0A=
+    int ret =3D 0;=0A=
+=0A=
+    /* If this message is a broadcast and no CCC has been found, grab it. =
*/=0A=
+    if (bus->broadcast && !bus->in_ccc) {=0A=
+        bus->ccc =3D *data;=0A=
+        bus->in_ccc =3D true;=0A=
+        /*=0A=
+         * We need to keep track if we're currently in ENTDAA.=0A=
+         * On any other CCC, the CCC is over on a RESTART or STOP, but ENT=
DAA=0A=
+         * is only over on a STOP.=0A=
+         */=0A=
+        if (bus->ccc =3D=3D I3C_CCC_ENTDAA) {=0A=
+            bus->in_entdaa =3D true;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    QLIST_FOREACH(node, &bus->current_devs, next) {=0A=
+        t =3D node->target;=0A=
+        tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+        if (bus->in_ccc) {=0A=
+            if (!tc->handle_ccc_write) {=0A=
+                ret =3D -1;=0A=
+                continue;=0A=
+            }=0A=
+            ret =3D i3c_target_handle_ccc_write(t, data, num_to_send, num_=
sent);=0A=
+            /* Targets should only NACK on a direct CCC. */=0A=
+            if (ret && !CCC_IS_DIRECT(bus->ccc)) {=0A=
+                ret =3D 0;=0A=
+            }=0A=
+        } else {=0A=
+            if (tc->send) {=0A=
+                ret =3D ret || tc->send(t, data, num_to_send, num_sent);=
=0A=
+            } else {=0A=
+                ret =3D -1;=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    trace_i3c_send(*num_sent, num_to_send, ret =3D=3D 0);=0A=
+=0A=
+    return ret ? -1 : 0;=0A=
+}=0A=
+=0A=
+static int i3c_target_handle_ccc_read(I3CTarget *t, uint8_t *data,=0A=
+                                      uint32_t num_to_read, uint32_t *num_=
read)=0A=
+{=0A=
+    I3CTargetClass *tc =3D I3C_TARGET_GET_CLASS(t);=0A=
+    uint8_t read_count =3D 0;=0A=
+    uint64_t pid;=0A=
+=0A=
+    switch (t->curr_ccc) {=0A=
+    case I3C_CCC_ENTDAA:=0A=
+        if (t->in_test_mode) {=0A=
+            pid =3D TEST_MODE_PROVISIONED_ID;=0A=
+        } else {=0A=
+            pid =3D t->pid;=0A=
+        }=0A=
+        /* Return the 6-byte PID, followed by BCR then DCR. */=0A=
+        while (t->ccc_byte_offset < 6) {=0A=
+            if (read_count >=3D num_to_read) {=0A=
+                break;=0A=
+            }=0A=
+            data[read_count] =3D (pid >> (t->ccc_byte_offset * 8)) & 0xff;=
=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        if (read_count < num_to_read) {=0A=
+            data[read_count] =3D t->bcr;=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        if (read_count < num_to_read) {=0A=
+            data[read_count] =3D t->dcr;=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        *num_read =3D read_count;=0A=
+        break;=0A=
+    case I3C_CCCD_GETPID:=0A=
+        while (t->ccc_byte_offset < 6) {=0A=
+            if (read_count >=3D num_to_read) {=0A=
+                break;=0A=
+            }=0A=
+            data[read_count] =3D (t->pid >> (t->ccc_byte_offset * 8)) & 0x=
ff;=0A=
+            t->ccc_byte_offset++;=0A=
+            read_count++;=0A=
+        }=0A=
+        *num_read =3D read_count;=0A=
+        break;=0A=
+    case I3C_CCCD_GETBCR:=0A=
+        *data =3D t->bcr;=0A=
+        *num_read =3D 1;=0A=
+        break;=0A=
+    case I3C_CCCD_GETDCR:=0A=
+        *data =3D t->dcr;=0A=
+        *num_read =3D 1;=0A=
+        break;=0A=
+    default:=0A=
+        /* Unhandled on the I3CTarget class level. */=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    return tc->handle_ccc_read(t, data, num_to_read, num_read);=0A=
+}=0A=
+=0A=
+int i3c_recv_byte(I3CBus *bus, uint8_t *data)=0A=
+{=0A=
+     /*=0A=
+      * Ignored, the caller can determine how many bytes were read based o=
n if=0A=
+      * this is ACKed/NACKed.=0A=
+      */=0A=
+    uint32_t num_read;=0A=
+    return i3c_recv(bus, data, 1, &num_read);=0A=
+}=0A=
+=0A=
+int i3c_recv(I3CBus *bus, uint8_t *data, uint32_t num_to_read,=0A=
+             uint32_t *num_read)=0A=
+{=0A=
+    int ret =3D 0;=0A=
+    I3CTargetClass *tc;=0A=
+    I3CTarget *t;=0A=
+=0A=
+    *data =3D 0xff;=0A=
+    if (!QLIST_EMPTY(&bus->current_devs)) {=0A=
+        tc =3D I3C_TARGET_GET_CLASS(QLIST_FIRST(&bus->current_devs)->targe=
t);=0A=
+        t =3D QLIST_FIRST(&bus->current_devs)->target;=0A=
+        if (bus->in_ccc) {=0A=
+            if (!tc->handle_ccc_read) {=0A=
+                return -1;=0A=
+            }=0A=
+            ret =3D i3c_target_handle_ccc_read(t, data, num_to_read, num_r=
ead);=0A=
+        } else {=0A=
+            if (tc->recv) {=0A=
+                /*=0A=
+                 * Targets cannot NACK on a direct transfer, so the data=
=0A=
+                 * is returned directly.=0A=
+                 */=0A=
+                *num_read =3D tc->recv(t, data, num_to_read);=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    trace_i3c_recv(*num_read, num_to_read, ret =3D=3D 0);=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+void i3c_nack(I3CBus *bus)=0A=
+{=0A=
+    I3CTargetClass *tc;=0A=
+    I3CNode *node;=0A=
+=0A=
+    if (QLIST_EMPTY(&bus->current_devs)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    QLIST_FOREACH(node, &bus->current_devs, next) {=0A=
+        tc =3D I3C_TARGET_GET_CLASS(node->target);=0A=
+        if (tc->event) {=0A=
+            i3c_target_event(node->target, I3C_NACK);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+int i3c_target_send_ibi(I3CTarget *t, uint8_t addr, bool is_recv)=0A=
+{=0A=
+    I3CBus *bus =3D I3C_BUS(t->qdev.parent_bus);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(bus);=0A=
+    trace_i3c_target_send_ibi(addr, is_recv);=0A=
+    return bc->ibi_handle(bus, addr, is_recv);=0A=
+}=0A=
+=0A=
+int i3c_target_send_ibi_bytes(I3CTarget *t, uint8_t data)=0A=
+{=0A=
+    I3CBus *bus =3D I3C_BUS(t->qdev.parent_bus);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(bus);=0A=
+    trace_i3c_target_send_ibi_bytes(data);=0A=
+    return bc->ibi_recv(bus, data);=0A=
+}=0A=
+=0A=
+int i3c_target_ibi_finish(I3CTarget *t, uint8_t data)=0A=
+{=0A=
+    I3CBus *bus =3D I3C_BUS(t->qdev.parent_bus);=0A=
+    I3CBusClass *bc =3D I3C_BUS_GET_CLASS(bus);=0A=
+    trace_i3c_target_ibi_finish();=0A=
+    return bc->ibi_finish(bus);=0A=
+}=0A=
+=0A=
+static bool i3c_addr_is_rsvd(uint8_t addr)=0A=
+{=0A=
+    const bool is_rsvd[255] =3D {=0A=
+        [0x00] =3D true,=0A=
+        [0x01] =3D true,=0A=
+        [0x02] =3D true,=0A=
+        [0x3e] =3D true,=0A=
+        [0x5e] =3D true,=0A=
+        [0x6e] =3D true,=0A=
+        [0x76] =3D true,=0A=
+        [0x7a] =3D true,=0A=
+        [0x7c] =3D true,=0A=
+        [0x7e] =3D true,=0A=
+        [0x7f] =3D true,=0A=
+    };=0A=
+=0A=
+    return is_rsvd[addr];=0A=
+}=0A=
+=0A=
+I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,=0A=
+                          uint8_t bcr, uint64_t pid)=0A=
+{=0A=
+    DeviceState *dev;=0A=
+=0A=
+    dev =3D qdev_new(name);=0A=
+    qdev_prop_set_uint8(dev, "static-address", addr);=0A=
+    qdev_prop_set_uint8(dev, "dcr", dcr);=0A=
+    qdev_prop_set_uint8(dev, "bcr", bcr);=0A=
+    qdev_prop_set_uint64(dev, "pid", pid);=0A=
+=0A=
+    if (i3c_addr_is_rsvd(addr)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(dev));=
=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: I3C target created with reserv=
ed "=0A=
+                      "address 0x%.2x\n", path, addr);=0A=
+    }=0A=
+    return I3C_TARGET(dev);=0A=
+}=0A=
+=0A=
+bool i3c_target_realize_and_unref(I3CTarget *dev, I3CBus *bus, Error **err=
p)=0A=
+{=0A=
+    return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);=0A=
+}=0A=
+=0A=
+I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name, uint8_t=
 addr,=0A=
+                                    uint8_t dcr, uint8_t bcr, uint64_t pid=
)=0A=
+{=0A=
+    I3CTarget *dev =3D i3c_target_new(name, addr, dcr, bcr, pid);=0A=
+    dev->address =3D 0;=0A=
+    i3c_target_realize_and_unref(dev, bus, &error_abort);=0A=
+=0A=
+    return dev;=0A=
+}=0A=
+=0A=
+/* Legacy I2C functions. */=0A=
+void legacy_i2c_nack(I3CBus *bus)=0A=
+{=0A=
+    trace_legacy_i2c_nack();=0A=
+    i2c_nack(bus->i2c_bus);=0A=
+}=0A=
+=0A=
+uint8_t legacy_i2c_recv(I3CBus *bus)=0A=
+{=0A=
+    uint8_t byte =3D i2c_recv(bus->i2c_bus);=0A=
+    trace_legacy_i2c_recv(byte);=0A=
+    return byte;=0A=
+}=0A=
+=0A=
+int legacy_i2c_send(I3CBus *bus, uint8_t data)=0A=
+{=0A=
+    trace_legacy_i2c_send(data);=0A=
+    return i2c_send(bus->i2c_bus, data);=0A=
+}=0A=
+=0A=
+int legacy_i2c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv)=
=0A=
+{=0A=
+    trace_legacy_i2c_start_transfer(address, is_recv);=0A=
+    return i2c_start_transfer(bus->i2c_bus, address, is_recv);=0A=
+}=0A=
+=0A=
+int legacy_i2c_start_recv(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_legacy_i2c_start_transfer(address, true);=0A=
+    return i2c_start_transfer(bus->i2c_bus, address, /*is_recv=3D*/true);=
=0A=
+}=0A=
+=0A=
+int legacy_i2c_start_send(I3CBus *bus, uint8_t address)=0A=
+{=0A=
+    trace_legacy_i2c_start_transfer(address, false);=0A=
+    return i2c_start_transfer(bus->i2c_bus, address, /*is_recv=3D*/false);=
=0A=
+}=0A=
+=0A=
+void legacy_i2c_end_transfer(I3CBus *bus)=0A=
+{=0A=
+    trace_legacy_i2c_end_transfer();=0A=
+    i2c_end_transfer(bus->i2c_bus);=0A=
+}=0A=
+=0A=
+I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,=
=0A=
+                                          uint8_t addr)=0A=
+{=0A=
+    I2CSlave *dev =3D i2c_slave_new(name, addr);=0A=
+=0A=
+    i2c_slave_realize_and_unref(dev, bus->i2c_bus, &error_abort);=0A=
+    return dev;=0A=
+}=0A=
+=0A=
+static void i3c_target_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    DeviceClass *k =3D DEVICE_CLASS(klass);=0A=
+    I3CTargetClass *sc =3D I3C_TARGET_CLASS(klass);=0A=
+    set_bit(DEVICE_CATEGORY_MISC, k->categories);=0A=
+    k->bus_type =3D TYPE_I3C_BUS;=0A=
+    device_class_set_props(k, i3c_props);=0A=
+    sc->target_match =3D i3c_target_match;=0A=
+}=0A=
+=0A=
+static const TypeInfo i3c_target_type_info =3D {=0A=
+    .name =3D TYPE_I3C_TARGET,=0A=
+    .parent =3D TYPE_DEVICE,=0A=
+    .instance_size =3D sizeof(I3CTarget),=0A=
+    .abstract =3D true,=0A=
+    .class_size =3D sizeof(I3CTargetClass),=0A=
+    .class_init =3D i3c_target_class_init,=0A=
+};=0A=
+=0A=
+static void i3c_register_types(void)=0A=
+{=0A=
+    type_register_static(&i3c_bus_info);=0A=
+    type_register_static(&i3c_target_type_info);=0A=
+}=0A=
+=0A=
+type_init(i3c_register_types)=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
index ebf20325cb..fb127613fe 100644=0A=
--- a/hw/i3c/meson.build=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -1,3 +1,4 @@=0A=
 i3c_ss =3D ss.source_set()=0A=
+i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))=0A=
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 3ead84eb45..cdf7cb07f6 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -5,3 +5,19 @@ aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read:=
 offset 0x%" PRIx64 "=0A=
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
 aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+=0A=
+# core.c=0A=
+i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
+i3c_target_handle_ccc(uint8_t address, uint8_t ccc) "I3C target 0x%" PRIx8=
 " handling CCC 0x%" PRIx8=0A=
+i3c_target_send_ibi(uint8_t address, bool is_recv) "I3C target IBI address=
 0x%" PRIx8 " RnW=3D%d"=0A=
+i3c_target_send_ibi_bytes(uint8_t byte) "I3C target IBI byte 0x%" PRIx8=0A=
+i3c_target_ibi_finish(void) "I3C target IBI finish"=0A=
+i3c_start_transfer(uint8_t address, bool is_recv) "I3C START with address =
0x%" PRIx8 " is_recv=3D%d"=0A=
+i3c_end_transfer(void) "I3C transfer done"=0A=
+i3c_send(uint32_t num_sent, uint32_t num_to_send, bool ack) "I3C send %" P=
RId32 "/%" PRId32 " bytes, ack=3D%d"=0A=
+i3c_recv(uint32_t num_read, uint32_t num_to_read, bool ack) "I3C recv %" P=
RId32 "/%" PRId32 " bytes, ack=3D%d"=0A=
+legacy_i2c_nack(void) "Legacy I2C NACK"=0A=
+legacy_i2c_recv(uint8_t byte) "Legacy I2C recv 0x%" PRIx8=0A=
+legacy_i2c_send(uint8_t byte) "Legacy I2C send 0x%" PRIx8=0A=
+legacy_i2c_start_transfer(uint8_t address, bool is_recv) "Legacy I2C START=
 with address 0x%" PRIx8 " is_recv=3D%d"=0A=
+legacy_i2c_end_transfer(void) "Legacy I2C STOP"=0A=
-- =0A=
2.43.0=0A=

