Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2021EC7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 08:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTymX-0000e3-0e; Tue, 24 Jun 2025 04:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uTymV-0000di-8t
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:13:27 -0400
Received: from mail-norwayeastazon11023087.outbound.protection.outlook.com
 ([40.107.159.87] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uTymT-0002RD-0a
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 04:13:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg2Rv7eut+DyjT22rM8EEqiX2BB434cDKZRxqb5M1T0xhWepc+CCiTcfYcY0Tje1tRZ9c+DzyU6HQ9X93XZXMZiySZa7m4Biv6YZVjbtainu5sTVRcNOLqP6A5NrNvbGKUIP6NVjUKJXkrW3OXGHtsInjgMgH+sWkKecOca6qsOVkD3AmytEdOFrO4qvGYjplbI6S9WsYOvfJ5yKaKmgh2p2cnnm+ucxVJ/pBveVx4dm59IakT2VNSkElFEfKoIvRVXbk2aIrW1YHryyKseS9g7BBOMq2PZCSVaq1FWBxsmywCSKV1sJ6ufP7B6D9NI8bCnUsUJsPYl8OrichPbxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZzi4qE38IA8efjwrcDwbGs2pQiQJS0I0TdlRoSpwqw=;
 b=bGdL/PD/1N9+Gt2Tl41QzLlNNUgi989lw8O8oaQbzu3jM0/S3BXALZ3NwhuET1MQyuLQ1EsZ3LRnnWTe6oa2ngP5sCnx3IguOIIocZp6r7XWxb2qzvD37iQ5zqnnRlqg9+A2itTPfc9F+n2O54geGPNqlBxU7WPtWqVF1Py3PkYchnoxDgkQXZV1spGiCrV6MxgogR/lcX4dE2//OkF2Dkg5+Z3k6+kHImor3wx7padQiZB5+7Kh2N8GSASHJmN67CiIwyTnW5f/OHYd+MGfK+sBMLEmvL8jqu+D0YclAIesAzCDV9+K5SGO2cYC81WVG6L9D+FTEsIWcyrIw5ypuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZzi4qE38IA8efjwrcDwbGs2pQiQJS0I0TdlRoSpwqw=;
 b=fec13IegV6waf83dYnPXi2HO+KBzttqqL0jA0PrYNfOrewrLHMxiMT8KWn30Lr4vb8syYAxzvvHpsA0KkJudPlGhW1VcCSZ1xf0RvS/4Nkoy5/41EoaKpPwkguIMhLtS5fXAR6SKETQuqR1LfDVs2tyb1+lJbDvsLg0Yvm5NlLK9JpcUXBBRSmC6qAxLcim2UFIfawK11FS356qSf1md03fRiCK776aTKBCeQswNYN1YN0vV25kN1WfzU1jfL4VbAbGTKR4TeOsZvaIQKHldkZoDoF2h2C84TwSP+Q3Nhh9QGfps95jELYyNH3PT07Y/8r6/VPUgxI9LR2J7uTjzyA==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by AM0PR09MB4403.eurprd09.prod.outlook.com (2603:10a6:20b:168::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 08:08:18 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:08:18 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: Aleksandar Rikalo <arikalo@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "cfu@mips.com" <cfu@mips.com>
Subject: Re: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Index: AQHbiHBMKhjxNs/1dk+vCUF69yvpRrNvpGeAgAlizQCADH3GgIAsCEIHgCEVE5+AB77KAIA4S202
Date: Tue, 24 Jun 2025 08:08:18 +0000
Message-ID: <PA4PR09MB4864695EE7137CA81D8CDF768478A@PA4PR09MB4864.eurprd09.prod.outlook.com>
References: <20250318134542.585521-1-aleksandar.rakic@htecgroup.com>
 <20250326123059.1268756-1-aleksandar.rakic@htecgroup.com>
 <PA4PR09MB4864D472FB32302BC1BD162584BA2@PA4PR09MB4864.eurprd09.prod.outlook.com>
 <PA4PR09MB4864BA648EA8F2BBBE2999478491A@PA4PR09MB4864.eurprd09.prod.outlook.com>
 <CAGQJe6r8vK2qQKgwU8cbHESUj0sn27aHAP853YkgofHHJPc=Zw@mail.gmail.com>
In-Reply-To: <CAGQJe6r8vK2qQKgwU8cbHESUj0sn27aHAP853YkgofHHJPc=Zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Enabled=True;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SiteId=9f85665b-7efd-4776-9dfe-b6bfda2565ee;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_SetDate=2025-06-24T08:08:18.2840000Z;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Name=HTEC
 Public; MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_ContentBits=3;
 MSIP_Label_d2ca9b47-09e3-4fe9-a702-e3ebef7456d4_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|AM0PR09MB4403:EE_
x-ms-office365-filtering-correlation-id: 8ebf26af-5958-4574-0e1c-08ddb2f6476d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?NsnJnEC1TPla7A3lzxfFIUfZ+sMZNRMxBNyYK7hA6zSD22qbDhudY0zrIj?=
 =?iso-8859-1?Q?M19QJ8kRANnGxMYGXcmkHU5j+h+EYclLDAyiiji4HAW6mvGpWOBz2KHHFI?=
 =?iso-8859-1?Q?vZPkYWOYMq3JvoWDXlNv0mPqDl2ez6KQixxkb9dnLyFTDc/y/qn1M7Jv5o?=
 =?iso-8859-1?Q?ZI35mBfJidsXKvo9GzGWnpyTmse9R3lxOCJMHB0lKCO155vynqLvtZqoOg?=
 =?iso-8859-1?Q?XcLMZki7mO/NnmERkOgq5S1N2PEJ1ZELM9EvbLlEzfmFgurc6puh/3Yd9T?=
 =?iso-8859-1?Q?TsoBjYLHtPopZLKTiMs4zAi57CAe+8Fm+cAf8k5LXx7oyUWm1HeH2ZhQso?=
 =?iso-8859-1?Q?c89GP6Ocoj2MXngct51ubkcWdNfM2lMjODfAQjyyVS1mk6WrYOPtUJkTEg?=
 =?iso-8859-1?Q?t/TI9d5jxWjInqccM30EbtModecdzbslNaLMadfgbhGRWcAwwcKD+uYfoG?=
 =?iso-8859-1?Q?9ujdGAMTtdpND85M6rFLoRW4MGSAeUkQyJS4zq29YDRvzJ1DOH3VRk5iwq?=
 =?iso-8859-1?Q?pLnr4VwWP1ZTBkioERnKOk+kEYaVaCE9m4SMFpnna6fD+Pa7zJAi+vXWoV?=
 =?iso-8859-1?Q?6OzozLK6QSCYs7Bu+9vrmO03J38WiRJjxQX5rTefxwbx0QjQn6fNHuIGld?=
 =?iso-8859-1?Q?1cqducD9mMPvLjb5MyGqKdKZPj9/xgo6SGQ6GEDxPpOVIxwgaFdOhLuLIQ?=
 =?iso-8859-1?Q?xuCQar6Cjpm7ovjiR/5WRWWQLZPJpEnYTe+x4Xtz3Kgncrc+/mQx5mhVp8?=
 =?iso-8859-1?Q?ITerHrqSVSXxs0sNzSUhV+fXyaORy/yC2mNokufb9Z3XSPs4jJGArCvt9c?=
 =?iso-8859-1?Q?xlwGUfWyUUoXc2X/ujHkgc9Flzh/+G7zib0yoHTg1PbJaSl0a5rLR2ZcMF?=
 =?iso-8859-1?Q?1K2tweN7d9csBOUmy/Sto83lLDNv62FtVAl0PRiEygJ0XTdK+Denobdr4U?=
 =?iso-8859-1?Q?6bLv5wfmgsZKkVyWKfhk3olP4Ne3DQfVF7MKz6H3HYxOi84nVT7zr/pxsb?=
 =?iso-8859-1?Q?rGMVsSjzFNz3fHHFfEXK3tJ2+DbpYTMSK0JHmKDRbej5gT5W4tkuKwozxI?=
 =?iso-8859-1?Q?ZiT9OA1vBsehFpOXin8LNX2jzhk8ga2fo2hQvDaAFA5uAA6+ZfQCjqVDVe?=
 =?iso-8859-1?Q?Cm4yexBajhzqH2mNIac6IelB/MGxtUFcNiL591f9KxErV4yH9uSRD9bQA5?=
 =?iso-8859-1?Q?wzGbxCKQ1cfbn6C4Px3Ug0sGqBZvrWNjJ1wOJiNZNTqxHukIIRUQbVfzsx?=
 =?iso-8859-1?Q?/RAnkIfr27mdjVRF2H6hTUCjs1fsDK7pVMb5BtdIcyJG4eJ5QCV4lz0bbE?=
 =?iso-8859-1?Q?Gjb/KvhI+R7b1kOpshkpi3BYG4AigtUMji0m897QyYHWRVd7V+uVvIwnQR?=
 =?iso-8859-1?Q?fz0Aag6wVryBhEAXQ6UkN3T9HaA+WsRN1TdT7Kih/xj/0xR8tSVS4cIC67?=
 =?iso-8859-1?Q?o0rSj9emEnxQ2uwK+WMV9jT0Kh1dOO5EqG4DPNburGl3aH+i/mOh4r92cy?=
 =?iso-8859-1?Q?pPXJGG8KLloQp91OymN/61fYLyRaTJi5TeHzjtBc87mw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?grbqlAvn/JJUn3ChXy+g2q33snlavE2WfA3/83qaPUrVCh0BD2zdQF0Rcy?=
 =?iso-8859-1?Q?3r1b78MaurMnDW68luhLeomhOhrhc6UpEcFGn4hpvsUrZcTPTYulPbkiWN?=
 =?iso-8859-1?Q?HJfV5BnKHhpBo6iNp+Etf2QenhR1PI+SE5wmdduKYU9G6NecPYcyls1nZE?=
 =?iso-8859-1?Q?YZo2LB5jt/iCkMK0r6SIKD6oEdxOONaSPmKFNsmrgUq0llxS3JoKx8/w8P?=
 =?iso-8859-1?Q?CWqVr1KmpY1HCdFxtLb6PEte9p3rS2wAk90D/z/E5rKBoNv1W3uDTzIp7K?=
 =?iso-8859-1?Q?fOKzu6+kHk40q4V35qMBgqk/QscK2ELH3XG+9GPDGbT8bwMp7bepgNdrXC?=
 =?iso-8859-1?Q?4UCbXzkDAhjvoI5xBoJmqpeeGfjODwjLgemMbWomxQrMJIpSgNoEEph+nY?=
 =?iso-8859-1?Q?ptoeS9upPbYckxfJWP70QZDyC13yaKHbCQlT8s1xGg3X0uqPrYIF1pVwWT?=
 =?iso-8859-1?Q?F3d9ySgRRemmH2PVuDSUzLGLFeZAlWerRJ8YL7ao3OItECA3AaEcdbWyIG?=
 =?iso-8859-1?Q?/GXJ6/4mLGwoGxOQu75WwE4TfgSEBVYfStbjkFlsrRx8Bn5HycKNmrWHGV?=
 =?iso-8859-1?Q?8A+/Do1JGR6GLDreWqKXOe/M9e4QiWFGxFTFRFHMskVUetDR0mYlXDnBs4?=
 =?iso-8859-1?Q?CkrJN+a+NomVDMGuSJe44ukrBHcHF8IhqtulO9GtqRjPRxulLARBdfh3ev?=
 =?iso-8859-1?Q?f4kj9sEUF6d0+lI5lxYhKmYrq2AJhLxZ0Zb+YcCGB5j6VElpoHFQwZ26Px?=
 =?iso-8859-1?Q?0s/POV8+A+fg8+hAR2b2tKKTwUX3wxKueKJfSgw6GIqSvzfWbXFtt+oPs3?=
 =?iso-8859-1?Q?ZHnbikIjUgBjhY9cSKSnD6ljfzlsUr9ZBWGb7Ry77wufM+w8P7HYjh1rY1?=
 =?iso-8859-1?Q?IAP70VcbhK0zZ1x9xStfIH5ZqrqFTA/a12gC2YEj915Nc8JKiJwoX1OrXp?=
 =?iso-8859-1?Q?1rgz4rtpqUwnKlSLA5sEfjlhKuWU4kD48F2oqVbLaB/ydL0hc8qe4Omfzo?=
 =?iso-8859-1?Q?gZiErn6ET2l3BJKsEs6ESsmSBeOPUg/CH5QiUqZ3LVIuisK3PTQvmV7UoG?=
 =?iso-8859-1?Q?urErGGNpKViGtc0t0t3skxhNoIoUPEMfUWR4/RuHeyzQTHEufwEjtNA+Wn?=
 =?iso-8859-1?Q?qHoXmvqbaVIcTB1MEGTCqnbpf7f0Rj3enL4Ya6Iu12LufHgO9G1StwNoLc?=
 =?iso-8859-1?Q?GX5XBKHiKY/NYs9C/gWt5YblXoI1DMpI6R46KfB+1IkgBjf1T2dhVj3Rm/?=
 =?iso-8859-1?Q?fZ4U/h70pjRMaE9nIi0KcsQYIsYlCPLQ3un8pIokLVzuCh8mFJAu/DwBBV?=
 =?iso-8859-1?Q?uCn9jCXfdVbKkMi+cCRNJ1MDo9YQq/YQmm/j9Q5HQA55d3NTjiwFnM+M/w?=
 =?iso-8859-1?Q?/fYNZ+EMqHX8Cl8YzfXoIb0CX5DKDBZhfHl7lLgUqgfQXWSNwqe4OCUxyg?=
 =?iso-8859-1?Q?e8/tjo2OByXst+me4w0w3i5RvZHO/ie3Esu3drfc/n0gachYq1LZ3DSe+m?=
 =?iso-8859-1?Q?/qqDfFhL5CJTY5rYI0r2UexIB3yBsr6oTOuXKkphhzCRwCJ9mnTguwSJkN?=
 =?iso-8859-1?Q?7V87vOJ5Ymezj3NI5JKbs8+FrC+Tdz6hzPDzMHGJDilBUjtjFcEDE01IKt?=
 =?iso-8859-1?Q?7PtZpsETULQ9pg54T6X4b6esEB7TNCUlMMgkE97DrAfZtMSaPGvMKx1Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebf26af-5958-4574-0e1c-08ddb2f6476d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 08:08:18.6077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSziFYmoRr4OLpN/PeF/d+Kial8oGSEZtJ0Ae2I8jr3Jml4GkvI2W6Ivj5ajiUHOUyqZNVR18Qnjn2xjvt1SlxUoBNeu+kntBumr4ExUQ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4403
Received-SPF: pass client-ip=40.107.159.87;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

HTEC Public

Hi,

> I confirm my "reviewed-by" for v5 1/3 (v5 is the same as the initial
> one I reviewed, except tests are added).

> Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

Can someone please commit this change?
Thanks in advance!

Kind regards,
Aleksadar Rakic

