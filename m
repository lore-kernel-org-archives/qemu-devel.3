Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F691C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 02:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvnIQ-0003bv-Oe; Sun, 16 Aug 2026 22:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnIN-0003bh-TX
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:41:51 -0400
Received: from mail-japaneastazon11023075.outbound.protection.outlook.com
 ([52.101.127.75] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvnIM-0007h3-A5
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 22:41:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKeVfgGlRyGH1Dq7mln2eLCt8REGjz+nvfo8A8LAPp4jrY3bz4wGff9H/jUyXTjQ9qyUbMi81HyGR2utKNxo06Rflt5+xzYaOiV74ikOUbCbO2jhBiKJWrdUNcSg5abWpsO3Az0NJHasBm8I9UC+bEBonpEl0PrfH2k/eCUK4akr71oCAxm+F+G4COlEIrynUosp/tfOY66TSoUASa4OquCNGsPw24UQfYF6D1WiLQUnFfFcnRbLQEN6BX4sKzMjUwJWzYEEnq3vfEctQxF/u299ys5WyZG4MRnaeLFkazPdqyDBaHK5+WDPltN2JShdTA33pIwX7fsCSFIxjhOAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p68+7E62YT+7/9s6bfZEt4/WMZBHGUqc9SG55YMS6Yo=;
 b=iVpUrseVetusqOv5SxSWYV/1bWObUThE2+6DsjXfuZy6SSiRfk58AigATA0L6yVwzJPVXPUsJBfgdNBra5TuCoNFuWOwz8peQd/mCUDFEIMkiqzkek5H6V+A6Anf+y2CsOAt4dD5ivvGTeXPHopvrQnuTdN5X/mGBJUn5G9SedPslvmbvLs9wNrGa3LikPplpTl48XsuJxplKyqZFpprbCt+RlSXjX/UkjltGAMyXuuWT/E5TGwcHTC3YqLBvoMR+ACBX612/mRow0j+RU748gkMKnt60oje9Eue7KVdPPkRxq+RvWN/YvcwEW+bJHH3yqCnqjomKvvfTbtoyL/0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p68+7E62YT+7/9s6bfZEt4/WMZBHGUqc9SG55YMS6Yo=;
 b=Q5xfvNBQ60LHCjm1aA73ZgPClwyNp+Clc7BA/iirW0vFXAncqQKTR+N03WLcaXj3SMuypiFMu/zyzLpWotlZuT/aZMNFgDZ5wIfs2eV92XsBEuDQj3NeSmnCOaPDCITdTO8w6kUB35+FvQD0yhXFbDgh5+luO51Z81u6b4faDZwqb+XwPvzmKRrOHhzEr00Le8F5IlUH/61CpFsNmCWZTFgReBvFxQnBSSs1Uz2wnS+L+FN62QI3uvQElFDgjtIxOXGokcOkSoSw/Nlmn3RhEfhehb+p0HHNx/hxchqbMkd4WHpvXJFTopAdImUNdrVgywsJed+SfDpfUlAk7uRv5g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB6591.apcprd06.prod.outlook.com (2603:1096:820:f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:36:38 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 02:36:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@redhat.com" <clg@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "philmd@mailo.com" <philmd@mailo.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 0/2] hw/usb/hcd-ehci: Fix Coverity CID 1685236 and check
 DMA errors
Thread-Topic: [PATCH v2 0/2] hw/usb/hcd-ehci: Fix Coverity CID 1685236 and
 check DMA errors
Thread-Index: AQHdLfE6jHLSPGMoQUKeRAuP2L2n5A==
Date: Mon, 17 Aug 2026 02:36:37 +0000
Message-ID: <20260817023637.3082135-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB6591:EE_
x-ms-office365-filtering-correlation-id: defe5728-344d-47a3-df56-08defc085cd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|18002099003|56012099006|10067099003;
x-microsoft-antispam-message-info: Qnbu0CEUS6hpLygNzwshbwOaNJgQCqfkmn7Fdktczj7Cx44MuMvReH9XhJyUlkOsdF5ygg5xAt268a2z0crA/9QQjrQ/piX3k7iphfAA60S7S/J+Enc6tq3pd5sWh1c9/zjnM4I4BF1W1XZ1N3MQTrvoaOalbO0t6gp/A9XB01jxaHrPPDlhgCklUa4Favl1p1A9DNSimyD61es6JzVcIh8P+hmyx7sV1Ri2NCbZjYzLcEaQVcE8jNzLtaLVG7ijFM3ZfmeIdknZ2bnA49fs8T9RVQ9LFbToPvQg3NMPF22WHw38nRoi59m8peDji2Tko6qGi/mpWEf4hsUoKKiDdK7Zx5CAncEPi9hweZD0V3F2r501ZCD5k06G+V0ZgndJJRpc9YuCWBiGTiimDGKugvnby13ibF0ocUnBMlSmvzqUBcOnN2K/EkzXvnURhmuA/41XFChiEqpI/Z1YN036r+/92MHvfAq8HxkYJT+3Dod4mR5Oq2dxQ5lY910klFtGjnPGfv4W+81tfEUhEUv65/2dfvls0Y8sRKB3vwYAUXJMnWppdnewG4BlwgfHKVVuQsuEBxxfBZHsE3epV9quRpCTB6qL/yFboUCZ1DG2PItvNeDYDYwEo+UVvItr5gNCF1ZPuZj54oaG9RKtaLpNedBfj4zkMTxQi3oMeAVEpztB5TppKc16uHyjm0Dp/tBcGlGS6CXLA4pIoLCTyjQH7rjKkaRBP9OLrwcv6OZdpYs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hi9TwgySOjXP28Q4qGr/WfxhcuSFn9OmDRNrfU0elliWYlDlSC3wyj+y6C9z?=
 =?us-ascii?Q?8PEwwKiuL2pWK3erUilhbuHdUWHnVZ2q1bm9kN/626LILvnZdh8ujB0mwwoX?=
 =?us-ascii?Q?3oZIO4LKjkzBjyvgcz4Mn1tTebuX74kcXgGaODFi+RUWOQtL6sY+b2xtOaGj?=
 =?us-ascii?Q?ulQ9qmOs+cNhG77BXN8ph5muvPGZ3n6Ax+765+qZ0e+eORSX5nN1cqzod7eg?=
 =?us-ascii?Q?igIKIEa2Hyg9lYq/lsQG4LPmorGwY17cp8MZ6GrBBGCHjjIGIM0MZXhOwKsX?=
 =?us-ascii?Q?uzgEBqLjv8duAfPd5jP+goRusii+ypI/y98h/RvKdroSJHG0UI9FvEg6kS4Q?=
 =?us-ascii?Q?9sXxnlge6BzheK14gcDnKrg3NARquoGgMCkhMQc461ZY4Lbs/a6YsVEfN4oL?=
 =?us-ascii?Q?92ETG5Hcmr9Ah5F8jlpb+fN6Xvzc0JqITutlXeqaqtJxBKV6ZFOF4VAlKBVf?=
 =?us-ascii?Q?t3ex1Fre0uuMgVDkyrxibj7Cgc9uUsLVMBJ19PCdb+XVtnWF0M48r3tMRvY6?=
 =?us-ascii?Q?kqZRkT65X0wRjzi/cXSRLhxxpuuRJ1uFi80XgWOXo0nIqJqz4I/jeZrFX5HV?=
 =?us-ascii?Q?sHpkoa6FV4U2oZ8Cr7sMzNYrx1tI7FnogbLC5uihAcNwV6G3Ha9vjyMwMDXM?=
 =?us-ascii?Q?gqd2ZcFaQJ+gSmFHq2Q51qvc3qasgFHHFE5rtbhw1o1j6cgDO0evC1CX8zgC?=
 =?us-ascii?Q?f0WMsLoYopNYZzJ5v/6ND8sWwNMnU9rlIq65M3ynBlFuIePjTtTJZccyHJtQ?=
 =?us-ascii?Q?a3dx93bTOOll8W/kaYd1fJ5P1wJrGIKPPk/ybETGZPN/prpHIxoru+d1aiPt?=
 =?us-ascii?Q?gJyjVEzuE42ZQ2m/84Jlr5VfLJxgCic/N058q1ZVNfzJYYM1nac6uM36WqfL?=
 =?us-ascii?Q?keuyfbMxhg5/7TO5twXwqGviNlBfqH7UlmPWw9+6ywbFfjcQXqEh5tUWV13i?=
 =?us-ascii?Q?wrPatTcEp7drFsR9+uUuF2Q+hPwTPVWee7heqFHtq0ThORyyup3pioUfTh/y?=
 =?us-ascii?Q?oImAiaYwKBsLvZq5lxQt/LXDijjGH9qd8cM+hFD6tdyQZQIY4abW+hO70Bhm?=
 =?us-ascii?Q?EfS+xj38hOrM0XBxCeHZBKY7Saa/HIZAP30vlfrkiwR9m5MvSZxcUkVla1Xk?=
 =?us-ascii?Q?VmMHS0anD0mAfgJYYnDCbfxj8eb3w0F3kYkmWdvBcVd0iATCJhE5VsEjSvh0?=
 =?us-ascii?Q?he7iLkqhdBt21WdsgctR3Z4rFk+WH+FKwccrvH81ysp0keReQraDs36DDRk2?=
 =?us-ascii?Q?JxIGmtZvCsVK6Ztoz9+IkT88yVUlPzTnYeOJBBOUEeu0/H/MiAOSMTckSg0A?=
 =?us-ascii?Q?gsfIhlMgHR1vkKD8NprWzukW8lFWLlI7/cMgxhxJ+44WNcDoP3dLhivI9/SI?=
 =?us-ascii?Q?d0XECY8LBaUU2aqYClsnMBuDqn9zZ3stfSOMRjlzLkhQIHixu/fzclkpAJV7?=
 =?us-ascii?Q?wq/4MidMe8SGSr5yK8vA8F4VoXniG9do5abEh66YT+e6+MySs3gJshpgUawY?=
 =?us-ascii?Q?JASPTDVPruqY7OK8D6fgdce0cBMQ0BaQTQnTbvwLuBAN0dWN33AaPfvE0B9I?=
 =?us-ascii?Q?UMa3HLtEB5OmnKX71Uhk46jn71ODFfRb1bQKhP2UyYdtMx3+kigL75IcRuHo?=
 =?us-ascii?Q?Q0gROe7hnos8AUm68IZ43O4u73THQ2GyBl8vn1zk45kA3uTOaAvTukA5P7VH?=
 =?us-ascii?Q?Cwj1TmHyIwIab0pLFZim+SUADk6oDwL72Stzjv+pca7Tx1lmoVGnAsXjGXzL?=
 =?us-ascii?Q?AXuLr+4+5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defe5728-344d-47a3-df56-08defc085cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 02:36:37.9890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2q4lzXgzk6+3nK7QIcirQW2G3WltEihs8/mUzED4D1slPyfjnnF6CE4J9FLdida7YZtsp6zSNTCh/3np/ER8dPrf5LujPBKxA7F5GQWIl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6591
Received-SPF: pass client-ip=52.101.127.75;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

v1:=0A=
 1. Fix Fix Coverity CID 1685236=0A=
 =0A=
v2:=0A=
 1. Drops the dead NULL test and checks the actual accesses instead, and ma=
kes put_dwords() return void=0A=
    since no caller can act on a failed writeback.=0A=
=0A=
Jamin Lin (2):=0A=
  hw/usb/hcd-ehci: Handle get_dwords() failures in async writeback=0A=
  hw/usb/hcd-ehci: Check for DMA errors in get_dwords()/put_dwords()=0A=
=0A=
 hw/usb/hcd-ehci.c | 48 +++++++++++++++++++++--------------------------=0A=
 1 file changed, 21 insertions(+), 27 deletions(-)=0A=
=0A=
-- =0A=
2.53.0=0A=

