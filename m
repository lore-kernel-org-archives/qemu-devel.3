Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C9CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdFW-0008OR-IS; Mon, 11 May 2026 22:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMdF9-0008NL-CZ; Mon, 11 May 2026 22:53:13 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wMdF6-0008EV-En; Mon, 11 May 2026 22:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBHsptwDYPVxIjyRbbj3NCMvx7Fiq804kZmNnhFtJdnE6TsD+nZ6rJAJRzM2lfodahqSyfnB/Ah36788r51il+JgSuxB/2WRk6JMOfIPpuZdcupLZxcTkE6PQC5ShGsMSW561av4PQpjOHEwR2t5txilfZG+I4aXDCpoLG0XawTHY/PqbpVJhJbtGDClrjtx08fF3++N1qjWqWSQCjOJlZpOEJz8PSD8KPOnLYKE3VuQQaHhcKt4GExBRoRWoQvg4Wha8YCxTp1kbox8QsL/F7Q8VyoODhMbJv2tWgp8OM5GLXKqIIvA9tObjoZL7ZlM6OcqOVmN7Zh3Hk+ZZlQYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=am2DK3CxFQiR+12pIFO7sijZXxaVJHzYXTCXMwAMohI=;
 b=kPz7jeMblUotHG/9lifJVYuSqWJ3eyrYpNjzVzd1iXTFttk7XZUMgSHzcjsh1Mwup5cp9msYnXWaGNCNXx7ErG1KxNYMpoGOlAEUTQNQRpG7MAzkO/E5VF10hWuy3wFtO6TJ3dNgYHRj1Xpn3CD6jCQ3yId4nKKdt1Cw0blVQ0iQWtMRqAscXo3d9x5Yi76OTOfT7yAgQS7rxVHgeK6U8IuwQjUKKuWDEYateH67QxETTcCffg/E6XJsVOG2IxtwyyI6g0bsxJsh4mtK3BDqEp+v2rxYqA/uNcZWj2oKhRgXwiYfb3+QZG7f+lLEz6+xn7RBzY9aXHJH8hKhG0+Rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=am2DK3CxFQiR+12pIFO7sijZXxaVJHzYXTCXMwAMohI=;
 b=QhJfCDO7SEtwLEwlIInK73P2uPEm+i/yUCtPv7IAxDGc44Pm9lOMQazMFIP5cawpS9hvAmQ3N9wsbzmjZxdgjq6DMkl1jtZtDzMIBOg7G2Z/f1vivwwF4ZA2pxx9qGkkspYBv+mIwkLDQQsSXtl5IQ719zo/BY7t7yyWcm29mnBb3R0Fb5gQ5+nt5vHIeWcpZz1zZrqYvNXAktfIZIfGVQPT8KY1Gav3lrrOrhNZQ1AxoQvGghBwnY3VV+LQp0LrXxuSLi5FdM7g6nB/O8kZrmTfe532dBJmeXkkfRrVPatcoZZrhynrCeIiOlqRTM01wmpF6FXISf3cj4rWSaRCCA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 02:52:59 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 02:52:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Kane Chen <kane_chen@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Topic: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc3qnQ7PoCz+q2K06UtftlgeRwf7YJtyqA
Date: Tue, 12 May 2026 02:52:59 +0000
Message-ID: <TYPPR06MB8206BD6FA4B76B8F9F3C945DFC392@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
 <20260508051619.3887383-2-kane_chen@aspeedtech.com>
In-Reply-To: <20260508051619.3887383-2-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6657:EE_
x-ms-office365-filtering-correlation-id: a3967b49-5a44-405c-a912-08deafd193cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: tNCT9+kUK31Hjp4dSwMX1/XVPEUg1l9hsz865ALqAvvRHVwdqHMSZD1NAAuk/zQAQVrQgnnx67Kaz+C2jbJnTt7GMCwYgBm70uX6LZ/B7A8bcbxQzo1u8OZaR9Q1rK0f4SW/vI1SdaML6hDAeJpocyBljAXxQboXNOiKyEEMOH0G9aqdh6EDpbY8mdE4G9L7/ocmAzBS4PfFeHGuIPAL/hLi5zdy3pUtB9xjFfVIZ+pwWJvr68SlSnvyoyagijmCprY4iqd6F0cn8f/tBKQU6KAwbRsMj+qde/pici4HLB/3QeKb7P1Ee1YMttrd18+uhyt9tXBPpp0RlVUfIxP6avgvnLrkq0e80sx+pu+5Qu1OjWhT4/0qhvoJwWN774zvVEliE1TMbWi2+ful8faPNjQ7iUXR9bXvbo8i0JAzgAwVIbdb1tUocIaOvqmlkqK3w2OFK6aEmQjmvqKAim9noNYbl4Ji1ibsR4sqiNPKNj0rIVvhuT+rARld6JK0YyYuLlZcqWh9oqRXaTgjngEPYJnGEq/5qcSnJp/wqokneyP8A3Pl49DcnW6j9NDiCXG98J0cEehEV2+S0B1ZOaCAI7J6ldCqMKnrzBNmPxFZVnffwoj1FJUKkdmFUVjw5BKKEpkJK+mMJ9cFCahKJ8uVKi9+exaItXGMIIpFdMol4wTV66G1SxzEjohNxT52JRjaKUI1LC0grFGzCHgpVe5Aw7H8Kt2A8HbYQnISEKWCqdSDvAO7CQszfRzcFFLinuhM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NjQOFS5GrTg2x1rLtGn11/ZAXjNKRPBWLtqdXv8+uevC55ipjAPYZH130B?=
 =?iso-8859-1?Q?6bIf0gILHgWHT5ZMwHhQzak/X3oryFEaqvA7VsGROeERJrfghhZZ/Qbion?=
 =?iso-8859-1?Q?vBaQ9EKQJu48Ca1uo/utSbZ97RlAmlhbI4zuP8a7shtbp4nV9DsfamVDVU?=
 =?iso-8859-1?Q?mysSFqjltz3ouvG5NA1cpw01I5hGCGFCpZC6AhUZQJgexsTTR6yKfjpQiO?=
 =?iso-8859-1?Q?izEJqPR0Ki0IrY6M5jubUZRK2WQnABh9cJmPC69vxQKLroDqwjjhWPw4Tz?=
 =?iso-8859-1?Q?LXafzegosUCipoiAG46Up7fDSVCdnLrOWekiKwxWcwKYMV+QV2phmQIny2?=
 =?iso-8859-1?Q?kNoeO62Mnl0sk/NceOkb0wxVVwfjxtzp3GSkmdpMPChXSGsKAUJ7dEG+ai?=
 =?iso-8859-1?Q?E7uKzPDrEqjOP86/SQPbfli1cX7Xznz3qcVTEWFc1OvpUIehiFGBMBIu5f?=
 =?iso-8859-1?Q?7+neMathlxjboC8kBAfmlAL8Axpwl+AJH9H3SFwxF0SPf9gdiD03PrvYFw?=
 =?iso-8859-1?Q?0JimEtQG4+ETBQ9Qor56cIK0eEaC0XAmgD1zH1v+ryNOnuomE4UdHs/wgz?=
 =?iso-8859-1?Q?EnbzA1ddB+5+965SlsgC3In5ftXTiIDk/NhfYS8Mh3hsN6KCWPk69Zm36p?=
 =?iso-8859-1?Q?YKx6qUKq1OUZG9KYWdSXhEZv8Vq1kiELh0a/i7nBEz8QfsBSGm9CzP1dI2?=
 =?iso-8859-1?Q?FnEnB8IJpvfhK23PJ55KG9UAKtykti5N+kK3QW0VHojuBJ/zvDh2espVb/?=
 =?iso-8859-1?Q?/wU5Nb1t68n8pD9Yl6NiC0H1yRToaaM2Hwzzo5LI3zYlGiEiu7nilkkj2W?=
 =?iso-8859-1?Q?pWXDluyUs4HS/LpznzKPXJrO4rvF6CKNCQ1TP7ZYPvTL4P1DeVrF3jA0Zq?=
 =?iso-8859-1?Q?ko3z0o+bDcUzI07JdacdWlmYZvS7rgw77xrYKJsOJVNqWYa0uSfh1x0PrT?=
 =?iso-8859-1?Q?ouTCpgvcG8PKBzT0Qib5WElLFPkuxfQrhrOjtgUcNJoWluVd3/BPVN0w8V?=
 =?iso-8859-1?Q?9tDt6h3eBdbQEuumGxStb6DrrEhv2a2U1kqE4K2UT+7emx8WcDdEDIw1/J?=
 =?iso-8859-1?Q?aytn2y543XyIKOljIPVp0xVMPzgQTPuJRLILFsOOUndf3wYVNjFyY3CJ8/?=
 =?iso-8859-1?Q?GRD2m2sj7GLsnbXrMOOoUoTep8floGXrhc6ZPwFiKqJdSXc+sucBCGM4M/?=
 =?iso-8859-1?Q?z7nTa7OCMgDqyfgOna1TQs997kjgAIsxepLjojAgnNXC87kE0t/gmUBThh?=
 =?iso-8859-1?Q?O4vt8jtXBWlsKMh9TiNjm5iFy0cRIktihrKuzunwNbe5fKGZJuF4U0m3RU?=
 =?iso-8859-1?Q?ia+lDVM9JRpggfPSRzgavtEUSJiVkz5MCLsPe7ARAjVK3PgK20NGpVmW9V?=
 =?iso-8859-1?Q?spFMOF323DXx9eGIaANeAGIDAK4QGSTjJYZAibuLGEaoyA2HhAB9o1tAiP?=
 =?iso-8859-1?Q?l0OqVb1ga1AOle9h+8qoTtc3cCGPPHHnWRc4WZWjYipwH6yj3XCc60tc6e?=
 =?iso-8859-1?Q?fKcXHH7gVl2baMrr4GN/DIUln6F3LkhNfsYnkyvHzJtH75eTpAMqtm0MNu?=
 =?iso-8859-1?Q?apRzxfIZrkJ45WYTe45htc97Hf7Pz93/RKZxgvkCMnKwjdPNWF5XPF/19H?=
 =?iso-8859-1?Q?y/nzi9dkO30/D/g1E4SWHPqfmlIjM/TluEUVZbtCh9F2pLHtWXj4d1k/Zb?=
 =?iso-8859-1?Q?VH1wI5qV/CfEVuOEQ99b4yYAK8tLOxoXi8xE+Tov2FH4PogIFd/okUhTNe?=
 =?iso-8859-1?Q?qlvIW7x2tODwNCki2CjBsVu/oI1IyXTtrfgEpSdOhPeJ7GgELoaltgzUAc?=
 =?iso-8859-1?Q?kRXx0trBog=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NvcEB7HW28uzfyIteQrFbfUstTGtMImGeBLU+BX0XtaenOvsz0L6BOPi0jR78eH9TeMhlkOcucq3kxSF9UqFWUiXK8pLZEB0cY1oWUrsBb3QIppCUicuucZpNkg+KwdfNr8A6KSWPdcuaN9S1xujaWwu4hNTyVKfkQAJ4OK4P/mqWmpMXDkQz0+cpNDw4ikxIf5wu2uO77TSrTkqE5/V/VToTb/FMJ3kM6UFPudKPj6o1zn/8eWcMNRsAzt8U4KNKUBsTVvqAmoM2sy/9OBV7f5fPi6d3DeO4LOc+alNgWFaOq46fXBsqFF9OJm/4FKff8SpMsMNj9nFLbxg6IPY3A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3967b49-5a44-405c-a912-08deafd193cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 02:52:59.5361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOhNMVlcEa5XNjhK/JxQxaHT7JWm6u72g8w4lrC6IRQap8zmZY/OlAJbZV6V9l7HtY2mfCXwna0wGbCbwMf9pI85e/hjjhtvwX+FdkxOZRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Kane,

> Subject: [PATCH v1 1/1] aspeed/hace: Fix mapped address may not be
> unmapped issue
>=20
> In the do_hash_operation, the code may be returned earlier because
> hash_prepare_sg_iov or hash_prepare_direct_iov may return a failure.
> When this condition is happened, current code flow doesn't go through lat=
er
> code segments. Finally, it causes the mapped address isn't unmapped prope=
rly.
>=20
> This change is intended to unmap the mapped address if there is any error=
 is
> occurred. Thus, it could prevent a reasoure leak situation.
>=20
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  hw/misc/aspeed_hace.c | 63 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c index
> 0504d61cbf..a322905cb3 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -218,8 +218,19 @@ static bool hash_accumulate_len(AspeedHACEState
> *s, hwaddr plen)
>      return true;
>  }
>=20
> +static void hash_iov_unmap(AspeedHACEState *s, struct iovec *iov,
> +                           hwaddr *mapped_lens, int iov_count) {
> +    for (; iov_count > 0; iov_count--) {
> +        address_space_unmap(&s->dram_as, iov[iov_count - 1].iov_base,
> +                            mapped_lens[iov_count - 1], false,
> +                            mapped_lens[iov_count - 1]);
> +    }
> +}
> +
>  static int hash_prepare_direct_iov(AspeedHACEState *s, struct iovec *iov=
,
> -                                   bool acc_mode, bool
> *acc_final_request)
> +                                   bool acc_mode, bool
> *acc_final_request,
> +                                   hwaddr *mapped_lens)
>  {
>      uint32_t total_msg_len;
>      uint32_t pad_offset;
> @@ -243,9 +254,11 @@ static int hash_prepare_direct_iov(AspeedHACEState
> *s, struct iovec *iov,
>=20
>      iov[0].iov_base =3D haddr;
>      iov_idx =3D 1;
> +    mapped_lens[0] =3D plen;
>=20
>      if (acc_mode) {
>          if (!hash_accumulate_len(s, plen)) {
> +            hash_iov_unmap(s, iov, mapped_lens, 1);
>              return -1;
>          }
>=20
> @@ -265,7 +278,8 @@ static int hash_prepare_direct_iov(AspeedHACEState
> *s, struct iovec *iov,  }
>=20
>  static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
> -                               bool acc_mode, bool
> *acc_final_request)
> +                               bool acc_mode, bool
> *acc_final_request,
> +                               hwaddr *mapped_lens)
>  {
>      uint32_t total_msg_len;
>      uint32_t pad_offset;
> @@ -275,6 +289,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s,
> struct iovec *iov,
>      int iov_idx;
>      hwaddr plen;
>      void *haddr;
> +    int iov_mapped =3D 0;
>=20
>      src =3D hash_get_source_addr(s);
>      for (iov_idx =3D 0; !(len & SG_LIST_LEN_LAST); iov_idx++) { @@ -282,=
7
> +297,7 @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec
> *iov,
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "%s: Failed to set end of sg list marker\n",
>                            __func__);
> -            return -1;
> +            goto fail;
>          }
>=20
>          len =3D address_space_ldl_le(&s->dram_as, src, @@ -307,15 +322,1=
7
> @@ static int hash_prepare_sg_iov(AspeedHACEState *s, struct iovec *iov,
>                            "%s: Unable to map address, sg_addr=3D0x%x, "
>                            "plen=3D0x%" HWADDR_PRIx "\n",
>                            __func__, sg_addr, plen);
> -            return -1;
> +            goto fail;
>          }
>=20
>          src +=3D SG_LIST_ENTRY_SIZE;
>=20
>          iov[iov_idx].iov_base =3D haddr;
> +        iov_mapped =3D iov_idx + 1;
> +        mapped_lens[iov_idx] =3D plen;
>          if (acc_mode) {
>              if (!hash_accumulate_len(s, plen)) {
> -                return -1;
> +                goto fail;
>              }
>=20
>              if (has_padding(s, &iov[iov_idx], plen, &total_msg_len, @@
> -332,6 +349,10 @@ static int hash_prepare_sg_iov(AspeedHACEState *s,
> struct iovec *iov,
>      }
>=20
>      return iov_idx;
> +
> +fail:
> +    hash_iov_unmap(s, iov, mapped_lens, iov_mapped);
> +    return -1;
>  }
>=20
>  static uint64_t hash_get_digest_addr(AspeedHACEState *s) @@ -350,6
> +371,7 @@ static uint64_t hash_get_digest_addr(AspeedHACEState *s)
> static void hash_write_digest_and_unmap_iov(AspeedHACEState *s,
>                                              struct iovec *iov,
>                                              int iov_idx,
> +                                            hwaddr *mapped_lens,
>                                              uint8_t *digest_buf,
>                                              size_t digest_len)
> { @@ -369,15 +391,12 @@ static void
> hash_write_digest_and_unmap_iov(AspeedHACEState *s,
>          hace_hexdump("digest", (char *)digest_buf, digest_len);
>      }
>=20
> -    for (; iov_idx > 0; iov_idx--) {
> -        address_space_unmap(&s->dram_as, iov[iov_idx - 1].iov_base,
> -                            iov[iov_idx - 1].iov_len, false,
> -                            iov[iov_idx - 1].iov_len);
> -    }
> +    hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>  }
>=20
>  static void hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
> -                                      struct iovec *iov, int iov_idx)
> +                                      struct iovec *iov, int iov_idx,
> +                                      hwaddr *mapped_lens)
>  {
>      g_autofree uint8_t *digest_buf =3D NULL;
>      Error *local_err =3D NULL;
> @@ -389,15 +408,17 @@ static void
> hash_execute_non_acc_mode(AspeedHACEState *s, int algo,
>                        "%s: qcrypto hash bytesv failed : %s",
>                        __func__, error_get_pretty(local_err));
>          error_free(local_err);
> +        hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>          return;
>      }
>=20
> -    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf,
> digest_len);
> +    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,
> +                                    digest_buf, digest_len);
>  }
>=20
>  static void hash_execute_acc_mode(AspeedHACEState *s, int algo,
>                                    struct iovec *iov, int iov_idx,
> -                                  bool final_request)
> +                                  bool final_request, hwaddr
> + *mapped_lens)
>  {
>      g_autofree uint8_t *digest_buf =3D NULL;
>      Error *local_err =3D NULL;
> @@ -411,6 +432,7 @@ static void hash_execute_acc_mode(AspeedHACEState
> *s, int algo,
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash new
> failed : %s",
>                            __func__, error_get_pretty(local_err));
>              error_free(local_err);
> +            hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>              return;
>          }
>      }
> @@ -419,6 +441,7 @@ static void hash_execute_acc_mode(AspeedHACEState
> *s, int algo,
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto hash updatev
> failed : %s",
>                        __func__, error_get_pretty(local_err));
>          error_free(local_err);
> +        hash_iov_unmap(s, iov, mapped_lens, iov_idx);
>          return;
>      }
>=20
> @@ -438,22 +461,25 @@ static void
> hash_execute_acc_mode(AspeedHACEState *s, int algo,
>          s->total_req_len =3D 0;
>      }
>=20
> -    hash_write_digest_and_unmap_iov(s, iov, iov_idx, digest_buf,
> digest_len);
> +    hash_write_digest_and_unmap_iov(s, iov, iov_idx, mapped_lens,
> +                                    digest_buf, digest_len);
>  }
>=20
>  static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode=
,
>                                bool acc_mode)  {
>      QEMU_UNINITIALIZED struct iovec iov[ASPEED_HACE_MAX_SG];
> +    hwaddr mapped_lens[ASPEED_HACE_MAX_SG] =3D { 0 };
>      bool acc_final_request =3D false;
>      int iov_idx =3D -1;
>=20
>      /* Prepares the iov for hashing operations based on the selected mod=
e
> */
>      if (sg_mode) {
> -        iov_idx =3D hash_prepare_sg_iov(s, iov, acc_mode,
> &acc_final_request);
> +        iov_idx =3D hash_prepare_sg_iov(s, iov, acc_mode,
> &acc_final_request,
> +                                      mapped_lens);
>      } else {
>          iov_idx =3D hash_prepare_direct_iov(s, iov, acc_mode,
> -                                          &acc_final_request);
> +                                          &acc_final_request,
> + mapped_lens);
>      }
>=20
>      if (iov_idx <=3D 0) {
> @@ -468,9 +494,10 @@ static void do_hash_operation(AspeedHACEState *s,
> int algo, bool sg_mode,
>=20
>      /* Executes the hash operation */
>      if (acc_mode) {
> -        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request);
> +        hash_execute_acc_mode(s, algo, iov, iov_idx, acc_final_request,
> +                              mapped_lens);
>      } else {
> -        hash_execute_non_acc_mode(s, algo, iov, iov_idx);
> +        hash_execute_non_acc_mode(s, algo, iov, iov_idx, mapped_lens);
>      }
>  }
>=20
> --
> 2.43.0

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

Thanks,
Jamin

