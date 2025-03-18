Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512FDC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWqe-0004nS-8P; Tue, 18 Mar 2025 09:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuWqQ-0004NL-Dc
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:19:00 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tuWqL-0005g5-7R
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNAbGQToAbKA06QRqTR5MxLnr20SOt9eMan59QsCVA9mnKUictidJb4PoUj0W7Z2Fhxq917CbwOfQWRRxNMX8vQMoyC8JXnPp6TOkINPFYlHj0qxPjHO+3EloHrjfC4d4gBpm2Tluw9yPOXOl7ukRZ477IjDuel8bOEJ5sXcrtYoZGHZJZ6OniQ+RbxBZQz62C85xKRq+hT1IemJsdfjaAg5Wj+mTbOaqcvNWvrUsUx6xMVURg8UAfjpsS/vRUsLV5anEV6cwV6plT4ZyyoderJ8YX4NxoTZkuJMnr1rvzBMA7Ewug/nOPgPoOWYKJWSY547nVWAYq2Jm5dRyYZuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hA/ECrQhUInZzsWKv+MdT9jKeJeKYaI4qs4wgq1pE8=;
 b=hYnA/JFSTb767pDAK/ah3gChKKf4ATW1Op+Qt6uQLm/O+4zv6AQXk9Pm6xIe1B/UV8dBynUo/TaJMzYYZrS8oh/NuOYJ737zFtkV1NDftbsI5823ZPoP/S7PN8WJYW2dL4VWq7IMdvpcUsEtnMAcQBFTESnLtm7WGjbj1k0CCl7Mne89tzSq4++vhN0NlzhvLZyeCql3B0LgcMtOkS3Vg/kHf1Yo1OKaQdfFc+xPx5lu3YLUEQWnAd/wNNovH9gVXpEKVvc5tVGxUSlycWEzgj9StdgYMc/rpKTx0WECaZ9TGZzTcK3cExz/022xQ8KxVybkNFknL8oSQuUcwKBcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hA/ECrQhUInZzsWKv+MdT9jKeJeKYaI4qs4wgq1pE8=;
 b=YcvWTuwg940+iTeCwH+SnqaA5rZa63JLJCIJBF9XfcIdJ6G7DeWKzJXjA2Q/5KkOHYKqJJBuhQCktDe4vybIupvC1q/WdYIKeoNe/lGJ7PyyIdI7cH0asLbumCwTaxUuryB0R7gqbxPL5J8pdbAULinl+lHKhx/U/VUdQ0p3/G8wXepoiB0DHHAygfrLhGDPzNG1ZhV4UYbhsrVBZtYung3RqzrDu+pw5Pi14T9VfrHg3xt8mKOiD0dOAx2RkV9vpRZU7jjog5qcAtbkLD4CKSSlJwTrkzOloj3cyocWuiyDNyjQIatV8n5IR5qshe3CX6wyeF5nqA5Pt+6UnTbG6Q==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI1PR09MB3886.eurprd09.prod.outlook.com (2603:10a6:800:12d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:18:48 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:18:48 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Aleksandar Rakic
 <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Topic: [PATCH v5 2/3] Skip NaN mode check for soft-float
Thread-Index: AQHbiHBN9WWu61L0jUe8EWyWqAJpArNvr5MAgAlK0wCAAAJJgIAAAvIA
Date: Tue, 18 Mar 2025 13:18:48 +0000
Message-ID: <20250318131836.584677-1-aleksandar.rakic@htecgroup.com>
References: <CAFEAcA_7TvkzcB=5Dw_oFvwNJW_7Oa5mFD9MmgbO7-pVb-hEYw@mail.gmail.com>
In-Reply-To: <CAFEAcA_7TvkzcB=5Dw_oFvwNJW_7Oa5mFD9MmgbO7-pVb-hEYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI1PR09MB3886:EE_
x-ms-office365-filtering-correlation-id: dd94236e-8ab3-4463-5e18-08dd661f6b5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?I4277Z6Q1Ub3PTWhIYD6+TdVCSpLXzTJOCd/XHaYxLmVRaZATnY6xJvxgS?=
 =?iso-8859-1?Q?m5MRs/GcREMX+odUx/CQvdKqpChBQTTWmoyKJujoqWRsjn3J5UalbHjp7M?=
 =?iso-8859-1?Q?JoGvUgy3YomCnsnLEVtDRt8EfJU5mbCppzlcNSKTHKCtZyh/bhVNZwQ1Mm?=
 =?iso-8859-1?Q?fY12vzmqrWT2fqg0NvCzJp+fcym32f9pWmDo+0Xdz0nZdhr+lhExb28pY+?=
 =?iso-8859-1?Q?C9JoOC0y4ZHZdP01Aod5uiPcoKB3kTZRbVqtG+Pt6JnexLnLdC8n2Ix9X0?=
 =?iso-8859-1?Q?MshrnmvX010Voag+5/SJ9R0IXz8xeiBhlR5O7BNBt556tYY3QpnjJXsR5z?=
 =?iso-8859-1?Q?P1NhIWWgDnbO5GeLpzCMNJWGRawISgvnZY6a+Gv47v2Cl6CsleLaEU3RTS?=
 =?iso-8859-1?Q?NwzU19nOwonTUTw0G7nzpH6QYwS/b3gFZ/8rUxrHTrDnDw8WFfavlP0skQ?=
 =?iso-8859-1?Q?ASQFhHUP1pqifVfTwbsvIHEydNLR/g23pwJr+yrXUl0yXGxzHd5bwjgNjl?=
 =?iso-8859-1?Q?uRkXRHeBqiWCrE00nXsmpdZzZFRr38haTBBGhHpcVMl579bpW+/PIybJhQ?=
 =?iso-8859-1?Q?DHG2a/VWjL4ePeDFkATCd45gIQZ3xhjqoTW1MUYFVLq68OefTVLxvep9n9?=
 =?iso-8859-1?Q?jS0Dpr+Q2A45dTe6vFoxwELF1Fg2UbBdq96XW5RFLc9a86uMh7wdjG8nB4?=
 =?iso-8859-1?Q?eIXZIwXXksUm/I3MuoPbZrXBr69K7uhBjNIYM6W/lFoKaAw1isRIeLLCpo?=
 =?iso-8859-1?Q?N2Gr4E34CPAKWpVkbXQBMGqmdQ1oDLs25oe9WpJc0zzRCv2r1I1aDGO7ag?=
 =?iso-8859-1?Q?J+UsXzAD8tUbn60Y6OjIxmdokj2k1ScjQK7GOIyF+zjF224gID45FioJrK?=
 =?iso-8859-1?Q?dMon0fWx8Qcf9TwW3/5xBHlI9hk1FqmW/fyX/p1jwsGCgJFn13b28QPh8N?=
 =?iso-8859-1?Q?BhU9o1+IXoMukK8msq9DfxWoWu2Scj/VEkeCNFIurSPzBD0UkJtv0QHdbR?=
 =?iso-8859-1?Q?uUZq6cUd/nj4eW/49atatgzk/hJiF2UNZcxgLEqCANsTsl+JDAJNF1wPbg?=
 =?iso-8859-1?Q?SZQe/D6Cc0gU4lbN/sBjPzbI8S9EIb+maMwB87LDaqqZ4g/HFjQh/fdmc5?=
 =?iso-8859-1?Q?AksW4XbpsceMsTdpklUwvsR9ZGsxHiy+ATAMx5DEKY1ej1mVO05bshrWQk?=
 =?iso-8859-1?Q?E2VNiY3L66X7XfFegTFdMpfXSUXDvH6H47c6O0DOPll+40ZkeaVMQ1azVW?=
 =?iso-8859-1?Q?zE8yCQvE5RJQ/GHWH34ZOb0RR8sp8TlNHz2/rp914L5Fa6NfhxVmXxFE1Z?=
 =?iso-8859-1?Q?LWCO0XM2KlFIOcPllNx1xf96DI0Rm9znFF6+pV29GjNue8Oiq+Q/Nspegf?=
 =?iso-8859-1?Q?RheNwEn/z9ue55BQ+MeX8JHpNFTvUAnpEhyqGKlsNG4g5t96Qzz8OzA+/3?=
 =?iso-8859-1?Q?mmd4L9tX9dBbAVLvwaFObQuO6Ml037CEgxnmv4NNRL0ZVVy4BGoyj8AGLh?=
 =?iso-8859-1?Q?AW5QrRnS3WkJVJ9IqZAI24?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H+g/Az/gZSD9O7+jiYrG9xbxpjgC3QxtJ1zYK05c4NFZzkW3/v3euY5CoT?=
 =?iso-8859-1?Q?VYsXb8xHgRWGG5qwRa4VyKjqZacV3IhXWnRvLasgj80k/RrqfO8MT478Qy?=
 =?iso-8859-1?Q?yAKecZZtLJbbkf8jLkyowj0v1FpU1KzClZYdqz00bSdOl93ZeWmvTKoMCZ?=
 =?iso-8859-1?Q?tw98Dmm206g0pujL3H6wGLCB1vBUhA1lskXwkYQMpYURr5Q1Xj9BCAX3dg?=
 =?iso-8859-1?Q?psBmWrugaoHP+oJHd/mNWj8Yu3SgkjkhnN4CyIwMAUVwP8+aS7XJFzu1dZ?=
 =?iso-8859-1?Q?jX0WvKQ9ciE/aZ235oMGoEfjjUu4aNhf/nRsEgUZPCYonZ3y/4KTkxYpRl?=
 =?iso-8859-1?Q?KtccPQ1wVZfxuY4exv1az2lZzdjGe2vrC6sKSM9W8HFE4crBrxIAq2+vrh?=
 =?iso-8859-1?Q?cQr8IPwKw3kdMS1IckdLMkNroTAA1R6JckKyOPeyCfT7+/YQMUauomTpmy?=
 =?iso-8859-1?Q?opyJCc5vye1NWGAv7WPULTvwYp6votpBmZJCITZuaMfccqSLk4Oh6ZTNfG?=
 =?iso-8859-1?Q?IVV3VKgD0dZdH2cUZfcTFpz7UfX6rvDLdEm2IljtQVqcTsQG/ngMTMtzGl?=
 =?iso-8859-1?Q?XSKiC3dPe9ZB+l71kX2ES5DOfa0g5F3Pk13LCgAOTs3M/fFrq/DWzQ7R1i?=
 =?iso-8859-1?Q?jyYKLh1CystRFPkxmLSHZ9iSf2Z7rMBQYWV8k/kCkz4ifIKvK6WqFQZZdq?=
 =?iso-8859-1?Q?4wqpFwK7HmiBXF+sK81XKwRwMQ7vj2MuReRmS5o6fel8/y76+FedsCq6o5?=
 =?iso-8859-1?Q?Wpigcip5MXPB9rG1xHCW80DFj1nsK3dGmKmfgXJWE0DxHf77Gvi8c4TNJA?=
 =?iso-8859-1?Q?RcLePhUqukj1CGEb9xzqzhF8xkdeaWvMQ7N4rDktGiiXRXdPcqscCglfdF?=
 =?iso-8859-1?Q?xGhHR6eHWhp1crVnh02x4u/ZprvH53B9BJ4o/Tc/JJa/ZPCXQJQ0yJlcez?=
 =?iso-8859-1?Q?jX3wOqrRjPG6YW3wrh1IZwQrTuJJiNyInSo9IZZq71R3EJ+16w7Wgk+kGS?=
 =?iso-8859-1?Q?2BneDXNnrE9qxRUOyUTZwOqFq6e5hde4R3jVUwmVw2tusz1zcx3AtePAWm?=
 =?iso-8859-1?Q?mF8yakWrUWbD4cljK8xk5t6ZjD5vbb+WIPX5gAmM2WxzUFw93xU032Y43J?=
 =?iso-8859-1?Q?Iv2IwPbNv6P5c+3G+FoBFGy/wBuIg9O5gt7Tv7k92eFbJdeQR//rlfKNmQ?=
 =?iso-8859-1?Q?hRkIcOyZ/QRP8xFhRBm3D4TpX8i/460U/TJkCuQje96SPPJywudZsk+2qn?=
 =?iso-8859-1?Q?azPwCb/tdE+qZ2NcMQTwPJWmG9cIvMo7+5ul9aNnkGWDnvZl/qgGZnzeVP?=
 =?iso-8859-1?Q?Ng7PfBnyGgVBhWLJhtiNtZuEEOmy2kfiuHAHbe3mrG5GyaCfBsNClZqr2A?=
 =?iso-8859-1?Q?qHI0+rndj1qLYpkadvY+Ck0bu14U/6VGH0e2yhpJ+wLLNEERXyjMrO/CcH?=
 =?iso-8859-1?Q?aCQUevmLab/IsAN3L5vgfDp54D6TREoNhRm6hPY6q31Kxj5GmfSde1MOZK?=
 =?iso-8859-1?Q?gYwdRIvdC8Z84ATb8BTHW2NUSdiqbVpqoe398UNZmDn8I4aUJOpxytSoay?=
 =?iso-8859-1?Q?yNdZzfVJn83GP4ie344SRdNUqEXMws5HKKvs3Lyozt16lXHNvhpWjnZ65V?=
 =?iso-8859-1?Q?9UtoKik5nVG74F1MD0J66jj5ZAFuWeLlA9X98KAxrLyCHJAUJmgRF9IWwv?=
 =?iso-8859-1?Q?uZsrM2MLNiTaqssSOi0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd94236e-8ab3-4463-5e18-08dd661f6b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 13:18:48.7401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJlWIpoVLQmx/n8t5VgASQu6++uhyv3G574/1Cd1zJbQigXgZ7aJyRu9KYKBkdWF7gvc0bKRlD5Bd4DkQIZm33wh8FWIzXGLJKW0xL0X8nQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB3886
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Thank you.

Kind regards,
Aleksandar Rakic=

