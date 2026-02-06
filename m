Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F18EB28C8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETc-0003UX-PU; Fri, 06 Feb 2026 00:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETb-0003U7-Dy; Fri, 06 Feb 2026 00:33:55 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETa-0007Vv-1C; Fri, 06 Feb 2026 00:33:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqCOLtAra1PX0ndGTMRM/S5kNRZSRhCUPG/dZ5iGuJvaSUKjb8GvjYbb0lGdiMRdADpzoPaK66YwIaRXkvou5hAd5KbCFuUoAuMM3PykyP2qPeU5fuJVa4s+oFovjN0n3MhNCulmmIWYJMSmwquye8pDj18jwz61duDA9Qvt36PJ5CezEl0Jwr+D8edgDeFK7wEAApdCwmINlOL5jHqzqMCeZ57f0LfK4B+Zi0zjJ1yLoOYKnT6a4fEckxb3hvN+xzRjItJpbqGO1MURpy4tDGMGYG2C1qB62GhdJW3LPn3vhusbQ3HQ8vft5EUMMp7H+IM5bKFj+V82y/ROZFavNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwz4NsdrkXNE84PbUuJ6L5IUb2/7xC6MdcRo15jdlmI=;
 b=LXkrILmClmH49Mwlo2KL5cjovhQu3ETvZOq+Cb+72VcBBZXHHjKBg8sFCSlglRN38B7Tt8nQxvxelPcOqO5GAl7ZXb4ykhOSkZBd4XV7/bF460mZBu9Ldc8Zm0SVO2s0fAPhGOR9FfPMPb1WiKl1ba7+808kAVtLCODFXxJCQ77k+TDzIbcWVd/YcH7XmnKWKnkoeboZVzVzBqNcfxT/u794s2UX7lgREwf+7enVkPAIGl7mBG1l4JFQ7hEAvcU87FWSXwcVZvpOjimZ/wPFlXqrmSbPmWouoEDGZjEjdZGzCTdYrGEqWmw3WUaeWLSNYHIQXrsB8/UyEBW4nONO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwz4NsdrkXNE84PbUuJ6L5IUb2/7xC6MdcRo15jdlmI=;
 b=Et/ytVB7aJZLzpOpTpGSKzJAwCy2KRuKHsgI5N3HGyk3GNQHlUoBG4Yt7bWl3XHwRZzD0Ht/q8QCjhUINc6hz4HkthqTdj9KP+Lkk4eXHYXL3lBWKfBgHp49iP6N81R3rMJT6jI8KGB5s9vCfYi//eYJrJR5lpBOZDV33QzQ1tGHXLPlH44Ujg1V6kI35Bf/Dhpj1SgPHhJRM3dCvOhtM4fSEfRTDVeGHZ0SmTgl6WQHVUhqB2Aysjmscygd17QuHv810oniP73LUP1I0CwtrlLImcVRtzjCc4O3YRPAV7mX2CF2MAUlmHsP0LD4myhIOWrSDI5Jx7fGbDbyxrzosg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:41 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v1 00/10] Support ASPEED AST2700 A2
Thread-Topic: [PATCH v1 00/10] Support ASPEED AST2700 A2
Thread-Index: AQHclyom2186LUNFREyi/PlKsz01cw==
Date: Fri, 6 Feb 2026 05:33:41 +0000
Message-ID: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5504:EE_
x-ms-office365-filtering-correlation-id: 56e17bea-5143-4a73-c240-08de65414976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FC3hFiijtaCHEfqYPXDfrLfwPzAv2qBJW37rGR+ydQGouqqmBLT95H2FO2?=
 =?iso-8859-1?Q?MEb2xWKLrqxNQFmdrttKARpi7uNZWVi9mIgJYeJgf3BEx1W8C45qlhDtIO?=
 =?iso-8859-1?Q?XDPIRU7Z2Zl8X+adiZOTvOxEpjeFBSqIWzZF14zWLQb1YACRSNRDwKgLnw?=
 =?iso-8859-1?Q?AB6SnOvYaEjDAQiq6K12IRsbl7qQNGz7gqSjzZbQ16mNe4zg2KYseyI12u?=
 =?iso-8859-1?Q?3K2R2A1uwzGOqClrq803EEXax7zQo9TLCxxCWAxDFem/Qy2JUniIkSOY2q?=
 =?iso-8859-1?Q?fOMYn8eVc4+WDEkRCuxX3TTWflh84foRO9L+50c07bq1Ns3aJrEQgzxTmI?=
 =?iso-8859-1?Q?Q9tJcl4QDmw3hXVXP0rdO7w+ge13N6D5DaOvi/xD2JEZ8laAfMFkVqpbey?=
 =?iso-8859-1?Q?bih4b0+KsxzDF76P0TiP+PZ8+KlvOGGCMnlymzjMPSkZyqsQwyiu9fa3aP?=
 =?iso-8859-1?Q?4xrfMDPFKPqv/K5Cbu39RkcEfz5LkV2FuG6FgVyGnMVSbDu3DL+NM2GEuc?=
 =?iso-8859-1?Q?SdtOclsLIPORMzbO9D4JY9HEml9cc02Pm+VpVoHoYZiFPLhX/19PFHYHR8?=
 =?iso-8859-1?Q?5euqEHe5AesfwtwMsYpZ+hu8UqaasJ2wKVXJa0jznM++f/uNYvr64+KkT4?=
 =?iso-8859-1?Q?6ErUD2skG06QV6xy/mW/jINKiAxvyTbw8vUBLpH0GDOfitCHV4120ZVjiT?=
 =?iso-8859-1?Q?j2SThDTAjw0sJWsJp7c06PX9+FD+ganJe+9Bu0ydrgqNe+PAoUwEcqESuI?=
 =?iso-8859-1?Q?SPDvw0enHOIfR0b7XMMNfMNYZZYdDQ6DlMgWQelvqaaKrdkTt/emEhk/W+?=
 =?iso-8859-1?Q?/QNi28p0kvAhMypvHgRsrvA0BLaBnEsYeKHzikZlfWXN1ORTiFMgntoCb+?=
 =?iso-8859-1?Q?za7UAoIqDLpLCClu0VFnnETdwTH4ubZkZ/jjWUXnGgKAhpH9bx6aiKAbmD?=
 =?iso-8859-1?Q?jcHLw6osGxPnj99uCqnfVYkRJJ4QL0mNM/0JtqOejsQ0+qcoG2OGJyWZmr?=
 =?iso-8859-1?Q?muu0bXvkbYkAJA78YwjTxzn/JM6DiwAXaMts8FcqvPR+b9taBs5tgARLil?=
 =?iso-8859-1?Q?WIoyDZc8LwR0zs9oMX5iQ0/6XwDSsL6jMwcGKRseqkTgJMvWjjBjuIe5/L?=
 =?iso-8859-1?Q?tJgyP/GV72/L9kCfDpY4K2Z1MXcjUzsc0Z+cJ6x5V/BfiBUKW+crzNrWLO?=
 =?iso-8859-1?Q?U8yp6/YXiDXS9V9/xX+ehTjbjwkLH+xzxERTK3rdn0ssj4fbIzVsOmWIeR?=
 =?iso-8859-1?Q?89kDRvawaxVz6qIcNNvoVKgIaY/F953L+esrsqa57R4WgHLNxWZ0UwAFmW?=
 =?iso-8859-1?Q?mUOnDW19jKa45u20lNyBhtwjvjw6pm8kEEbtf/f7HBGZjUubNrFl2ZyVjg?=
 =?iso-8859-1?Q?yR9VE9prk43bawzmmsAED5TeeP2yh7objO7/p6fs42uVqpMlqBQQzVE8FB?=
 =?iso-8859-1?Q?AMWLjw6/h++PTCtSu2laIOOjt7OQ4J5+fLYf/kyK6mKou0Ly38xdC54Rgy?=
 =?iso-8859-1?Q?SqIJY+TBs6vF6Tx1IpZ7xraLfQW/e8fSRTDTG2exLEXOxPbjI3ppTvbQEi?=
 =?iso-8859-1?Q?hqWeE/ueSLEuCrN05dsh+FCqD8zAUFez54ejdsaqEurtJKdUMI5II0Uocr?=
 =?iso-8859-1?Q?qJTcLzzk9tFMljGLl21n+P6iT40aErrnK49/z8ZGeK9fsGA0IxThNFZl6N?=
 =?iso-8859-1?Q?TpSCEG4Djg2SCuJjb1z0KCZUwoL6pJJxThJgsOQS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JCLCIBwB7/rdw3GzQpBtSQdtQHUONSf7m7Mxbsc0wXH8gIQqimDhvb/Szw?=
 =?iso-8859-1?Q?N+9yU+FnT8YLZ45ZcBUixE+y8rbT2RsQNW2qpgyKf/aX3rrI3tM+at90/r?=
 =?iso-8859-1?Q?isJeHqArqWr2M0qPdOzV2CLTKa47C0v6LEY4GAoggfO41vm4yJw8QMhhAa?=
 =?iso-8859-1?Q?5IOj1KdJquTFSeknJourhSFgsUHDk3buIUFWE+JSqxNPWASfEu+sFPNuma?=
 =?iso-8859-1?Q?K22DYyeo1SuSWJC1kWQjI2Y7xqqD8RLUTxzbejp9ao+9F3J4hdkq5YIkKA?=
 =?iso-8859-1?Q?g2crgT14h8jVjVzv6rOm9Wb7xBqKML2JgvDCSrkwZ8Cy7vMA+KVK0yChl7?=
 =?iso-8859-1?Q?sv3BX8MhEYKFq1CIdg272wV2JDpCnzVDi4zBoZx/gVgJY0Qc4x7FAUL3df?=
 =?iso-8859-1?Q?rzC53xPezkLeq/xxFzae3FVXDNfZ/tnNuVGqcD0g/fkGlTsTRCHiaCJWK0?=
 =?iso-8859-1?Q?WZLYpDzDXDS/Ea3IYZFI+2YxoK3HOZsq9TRclDfbVN8qDVc4I1bGamonfP?=
 =?iso-8859-1?Q?0NN9btraG8oMGVL/NyuyLpHl3Ur/pHQumFUYQnIGnEQjGw7k4AOobqHdlv?=
 =?iso-8859-1?Q?FscJPiI8p6kZrsntmJAaIVHkCcRF7rliXF120BHfYdYU9Nd0o6vRc/MBkz?=
 =?iso-8859-1?Q?+S5y5LK7QOcFDZSQdovQXIF3e3la9BwiiYOTHAeTGaxIwBQfA4Li470zBm?=
 =?iso-8859-1?Q?j/eZ77lCa2bUx+Ov8aZL5P0JjszSbuNt0pZGukVxkpnVFcLivSK/Ds34HY?=
 =?iso-8859-1?Q?tKq1nu1fqg6Ru289AzjP8z2UnmDRhxC2n13kIGE3OFkY9nRgD8aTamOMjm?=
 =?iso-8859-1?Q?Inm+W6HPnbFyrn6qOeez0FgG5pP9MZ6k19BBoKvbovBuIxnBJjyFKk0Edn?=
 =?iso-8859-1?Q?J9Tk5xab77TUvddOg7lSCV3Noc3cl7u10BjHMbdDqNNPtWRDzzCM74o/cq?=
 =?iso-8859-1?Q?/GS0CztkUf9MLZmh/3P0ouM1KaLsSZ1wJ8pvL1Kyr0iTT5asjk+dBGh8El?=
 =?iso-8859-1?Q?LLdqYQ0cuOeVCpN05kJTgBNbbXHEGbzF+kk7GaVQp3Wkq0cY9yeSqIpKqg?=
 =?iso-8859-1?Q?lf07LUGrBoljHhquFhLGSiQldNXh8oi2rdJgiNd8C8D16ySz7Wc366l0dT?=
 =?iso-8859-1?Q?/6+VHdGKIkiNi3q5WCOxYJLnV9cxN4QJOdu0jJjkxgeGSJaycNsJ8KCJe0?=
 =?iso-8859-1?Q?9LhR0pk+6fdVXarkvNPgSlMBKWPWCwROIPvOBq6NibKRaFM3b8IBwBVHRS?=
 =?iso-8859-1?Q?5vjEMufgQX+wtTleTKhxYqZgYDt/zJl10sS+hRPZE8jmzNuAvHcEXZWpyD?=
 =?iso-8859-1?Q?3kPz8BZ7+PJey+BstUkZ9G65J3ejEQJZjophfkSYbXqJqMwI8+fIngwWQn?=
 =?iso-8859-1?Q?+fe0LzX66p1PNrkXz+4+jMmDZFnZPpKOscKg0Y5pQAgmzC7FjaP408YwHn?=
 =?iso-8859-1?Q?qIyIZWaljIegpypsVoqV4S8+yzTPAuQS/kaSNIfcYl1DNq7GL7n2LGCsIQ?=
 =?iso-8859-1?Q?gvwC/qLuVLwkxThkM1cigzWukD/YiPv15O8pg3iEesod7ZbzBtNw4XC9IO?=
 =?iso-8859-1?Q?GFJwqskhQM8xOZOS1gFPPKx2/8TMhATpfioOuZ/6c5QhAOiTQNpg40Oknk?=
 =?iso-8859-1?Q?/FNKtr4OLHQI7AhOndIze5X1ymyXVLN9nqUcUSH1yfRuiYXE9BxRBpINrA?=
 =?iso-8859-1?Q?5UU5AQoMZS0q4oGOJdRcW0fTX9Am+R4PwbWvvBJH+c6GPFz+RtDh9519ZT?=
 =?iso-8859-1?Q?FM1C3R8wn66rss1RM/Z5qcFBmU6Glosf5KZiQfIlBKdsEd1pWUc9NLLXj0?=
 =?iso-8859-1?Q?AR35asx74A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e17bea-5143-4a73-c240-08de65414976
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:41.2731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/ckW2woqMHxQXC+O7+/32/Y/Q9Z0cUuOsjRCtb+g1sMGUff/maKXUveq3u3z63mzRq2BJN4p1vBsQmnX/8qByql0/z29gpa9qnZU9qH0vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5504
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

v1=0A=
  1. Add AST2700 A2 SoC support=0A=
  2. Add AST2700 A2 EVB machine=0A=
  3. Alias ast2700-evb to ast2700a2-evb=0A=
  4. Switch AST2700 FC machine to use the A2 SoC=0A=
  5. Update functional tests for both AST2700 A1 and A2=0A=
  6. Fix I2C Fix Out-of-Bounds access issue=0A=
=0A=
Jamin Lin (10):=0A=
  hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by using dynamic register=0A=
    array=0A=
  hw/i2c/aspeed_i2c: Increase I2C device register size to 0xA0=0A=
  hw/misc/aspeed_scu: Remove unused SoC silicon revision definitions=0A=
  hw/misc/aspeed_scu: Add AST2700 A2 silicon revisions=0A=
  hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support=0A=
  hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB machine=0A=
  tests/qtest/ast2700-hace-test: Use ast2700-evb alias for AST2700 HACE=0A=
    tests=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Add AST2700 A2 EVB=0A=
    functional tests=0A=
  hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine to A2 SoC=0A=
  tests/functional/aarch64/test_aspeed_ast2700fc: Use AST2700 A2 SDK=0A=
    image for FC tests=0A=
=0A=
 include/hw/i2c/aspeed_i2c.h                   |  4 +-=0A=
 include/hw/misc/aspeed_scu.h                  | 11 +---=0A=
 hw/arm/aspeed_ast27x0-fc.c                    | 15 +++---=0A=
 hw/arm/aspeed_ast27x0.c                       | 36 +++++++++++++=0A=
 hw/arm/aspeed_ast27x0_evb.c                   | 29 +++++++++-=0A=
 hw/i2c/aspeed_i2c.c                           | 54 +++++++++++--------=0A=
 hw/misc/aspeed_scu.c                          | 11 +---=0A=
 tests/qtest/ast2700-hace-test.c               | 22 ++++----=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 44 +++++++++++++++=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 16 +++---=0A=
 10 files changed, 169 insertions(+), 73 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

