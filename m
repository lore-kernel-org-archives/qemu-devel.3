Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3045C48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 02:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbWTa-00015H-6q; Sat, 17 Feb 2024 21:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoyong.zhong@nephogine.com>)
 id 1rbWTY-000157-QB
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 21:00:17 -0500
Received: from mail-mw2nam10on2138.outbound.protection.outlook.com
 ([40.107.94.138] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoyong.zhong@nephogine.com>)
 id 1rbWTW-0000Kn-V9
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 21:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtegkD9wLrBg/yS9AvM53r7lg5Kj2Hjl3wu9xhS8+mJzobnW8U0MbimostGYoi48iCycqqgmbHmmisLLe75kh0q69eMhcNBs4LvGzhN/XiGC/1w1LiGoSRTpue9aaQotdif9u975AjJHdKsAwwmIqMfJX8vJBZucpgB5gHo3QRrZRkSLa9w65Ifjy8bxXet0k+CxBP9fMgMKdKt99TiS+p5ghGSVn/WJQWB5SjiLmAakvXjgKBsSjFmNqYwouIapHMImeNWTx+sFzlWCI3pfa2IQpI0IDK/zoRK13jInTNTSMgSlBGFk2UvaGYKBr6nveip6EQJf1UHH+LHkeCCM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muAbBe5g9bsdC0snmcHfQp3gUZ1Z3xRIYkE4CW+hOsw=;
 b=mt+74TDI4OZ71zSUj4yVdFxxL+poSL14E4jWnyvWTSVU1f9G9HKkQAIUHZFy/cJ1pkotSHRrJI1mjmmxDORiG9k4nOQmn3I6oR4SogzzwUsVhfCEK8u6W7+NP7MzpgxZnA5WlYlThJUVjiwka6cFG7zKg94+SqnMonRdA+MpX8gNwAZuqEa6BszQOTGeZwr8TIXNo4E/ylosR+jEh3uuTiZMPZQE2WMouJVG2TKW6ID4Jo/NBcD/PNvlif6soS5bR+j/ZhPkIOzM4JC/ELUaaHbjFxtfojGNJ75SpWgbSeTyHYo5zuH8KJ9/8E1bXlde88TcnKpjykOCXYIA6he0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muAbBe5g9bsdC0snmcHfQp3gUZ1Z3xRIYkE4CW+hOsw=;
 b=3Q6cp0Bu2ZSAq+WXTGfv/1bx2fTjLf0Nr5l+QWdKSd6+gGdN4yaCeY75KhHxxJzoUXBfnzyzWTvQrMTqJ9MoKosob6OkLDMUeLfJn6SHCFYFQw5ZwxuCaalyCEcpedgwIKOMGMbrLj6ajVm6br+WC4EmNqcb34JWfvPGq4gynAxk+zXqgUpDkaCujzoM/sV0Pjq3DA6U3WH9LpsVcYGXiO6XZUZ0LmOsWRbvwNJjGYscsxYdZ9iSdCCP5zkB7S8/0zrjvBM8ZIA4i9CZU1NHkpkmNeOCQpPW19dZNUKYMdk8pCA3SwtsthBgqNz289E8bNXi8VLwchIRhA4CEzVPaA==
Received: from DM6PR13MB3988.namprd13.prod.outlook.com (2603:10b6:5:28e::12)
 by SA1PR13MB4896.namprd13.prod.outlook.com (2603:10b6:806:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 01:55:08 +0000
Received: from DM6PR13MB3988.namprd13.prod.outlook.com
 ([fe80::dfdb:af69:82f4:cad9]) by DM6PR13MB3988.namprd13.prod.outlook.com
 ([fe80::dfdb:af69:82f4:cad9%7]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 01:55:08 +0000
From: Rick Zhong <zhaoyong.zhong@nephogine.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Wentao Jia
 <wentao.jia@nephogine.com>
CC: Eugenio Perez Martin <eperezma@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Peter Xu
 <peterx@redhat.com>, Guo Zhi <qtxuning1999@sjtu.edu.cn>, Xinying Yu
 <xinying.yu@nephogine.com>, Shujing Dong <shujing.dong@nephogine.com>, Kyle
 Xu <zhenbing.xu@nephogine.com>
Subject: =?gb2312?B?u9i4tDogu9i4tDogRlc6IFtQQVRDSF0gdmhvc3QtdXNlcjogYWRkIFZJUlRJ?=
 =?gb2312?B?T19GX0lOX09SREVSIGFuZCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBm?=
 =?gb2312?Q?eature?=
Thread-Topic: =?gb2312?B?u9i4tDogRlc6IFtQQVRDSF0gdmhvc3QtdXNlcjogYWRkIFZJUlRJT19GX0lO?=
 =?gb2312?B?X09SREVSIGFuZCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0dXJl?=
Thread-Index: AdokPrZLsAJfb0btQhCy7EbMDce/EgY4mSYwAAJ9PgAABGqn8AAAz8ygAfvHuzAAhk7OgAA1l2oAAAD22YAAB9kDgACXz1iAAAgyIIAAAEaZwAFcG0xwABOlOwABFssUYAAMR9GAAB5bYdACNqaugADquGNQ
Date: Sun, 18 Feb 2024 01:55:07 +0000
Message-ID: <DM6PR13MB39880A261589BE275809C69F95522@DM6PR13MB3988.namprd13.prod.outlook.com>
References: <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
 <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWc2P6iHrG9dR2X9YC=P7dw4=Y2RwRkr5H81hkj6ej_5hA@mail.gmail.com>
 <DM6PR13MB3988D0E01FE275F72E53397295702@DM6PR13MB3988.namprd13.prod.outlook.com>
 <SN4PR13MB5727A733210FBF7A3B72DDE886792@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWdx+33QrtCkMDAMG=1au7jKCgw4bcmgC+zgEcXaeW=Fbg@mail.gmail.com>
 <SN4PR13MB5727E433825757E3E326EB9F86432@SN4PR13MB5727.namprd13.prod.outlook.com>
 <20240201075513-mutt-send-email-mst@kernel.org>
 <DM6PR13MB39889A667DB46A0EC65FA08495422@DM6PR13MB3988.namprd13.prod.outlook.com>
 <20240213044703-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240213044703-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3988:EE_|SA1PR13MB4896:EE_
x-ms-office365-filtering-correlation-id: f2d19103-cb42-459f-ff98-08dc3024a23e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZgDTrRFHR1FVW2jmm/KuZpfMWwphyGNBVAsnMWHMIPhKeO85QSJvmHXnF7Hf5HR1fd7WvZG1tI6RI29BRTbj7Gd6pb44WmHUbNVI3l2vYrXnTH4rmnZ1cLJV6JUEps5NR0z3OtynCbtadBriUv0bh9B43UtfXRZEXs6flHKgt7mANykwYSFODRo1AOOyAjbwdWc0XIyzk0Me62a2CUb77VhnuLsID6d0LmZPBvCgfs41VG2l9rQuGVr5GYC4Yklbtxb7jNeCOmKv+BNnjlRFnyqKRWImN+VXwRhgCVGLqrR9FrDQ5I/xGDJtVbSNWCwXi3uxORwoGUBsU+MMk7PlBGwsi/COQOVAFQsfvsleeuuPP7bnbZV9T1qicijMdRnADNpKuvTDSmWrTVoR+HVXA7XWbkfk2cqoz5PPXw11lcQWAaohIzCUHUzixy3hparnt+KY9xRq7SY4K1H/iZnzDKKt+dEHj46OtH0mhpNJNLP7q0a/laY7cxthp8h1Hj1m1nFc814pRyKbST+QhOv5uoCt4QOUORx7Xrpz0sksZ+6htQANpn5vPr+vP+U7R7F2njyLgVN+bu0nkqHfTX1n3DJta/RCgQsvToPEzJfZE4j0xveH4lUn+vtXDshbwi0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR13MB3988.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39830400003)(376002)(136003)(366004)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(9686003)(6636002)(7696005)(6506007)(316002)(54906003)(478600001)(71200400001)(110136005)(52536014)(66556008)(66476007)(66446008)(64756008)(4326008)(2906002)(66946007)(76116006)(8936002)(41300700001)(5660300002)(86362001)(38100700002)(33656002)(38070700009)(224303003)(107886003)(122000001)(26005)(83380400001)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TnA3SGhiS1c1eFJpVWNHdEJmT1hwS1B6d0NxM3FGdCt5TGFtdUpJZkJIaHlT?=
 =?gb2312?B?T053MDhTaUVXcTJLaHFlYVhzUjF4aTRBTWkyTTU5UFJmbmY5SkdlMUYrSnJ2?=
 =?gb2312?B?UlR1NFB6TFpHc0xtaUVVY2YrdmpocldlcklRckVaZTZFUFg0Ymd0RkdkRGhC?=
 =?gb2312?B?bzZrazdYVlNyZEFPV3dtNjFtMDBrQXZxWDI0QWhVYnB0MVRhblVZN3dkR0ZP?=
 =?gb2312?B?M0tnQWlEWGlrOVlFNURpeEJtTUVMWTdHTk5jNmxqdkZTRWNLMUxCbFFreFd1?=
 =?gb2312?B?eFVHYk40SDNZMzJEOGRTdENFVEIwU3Z6TGFUWFJ1eXJZdDIvNHJMSUUzNmo2?=
 =?gb2312?B?V1VGR2dDaVQxeU1vOEcvZTlYYkFrM01TWDJRaVdaelE0VHdVRVZnbkdjSDI5?=
 =?gb2312?B?UWFVS2l6NUpZb21SSzZNUU82N0FvT0R0dTQ4SzFFdTMrVTVJNnpIQThITkxX?=
 =?gb2312?B?YlViSTRlTjFrN3grZ0sxcmNwNGYvWSt2QVJMbjZrUWppNUxzTUFrUzJ3aU5E?=
 =?gb2312?B?SFkxMzgvQ0ZxcWpXRzRyMko5MS9QeWo2L0Z0WllUd0NrS3RuMmZQa3BNbGRL?=
 =?gb2312?B?TngvWk53ZlZjL1E0WkZia3ZqWkw1aXU2REM2d29USEN1TGcyS3JOM3YyZkRo?=
 =?gb2312?B?NjloeFhwWTRpd2RuMnZyd0EzRDR1LzNUSFJRNUlwYXZ0Q0pxU0ZDeWJtSms2?=
 =?gb2312?B?N1FleGN2T1lZUUdRSjZmTS9pSG9wbkFTT3VTVXhNU3Z1OFB3V0J3eTlnT1NT?=
 =?gb2312?B?ZHJzZFR2WmtQMXRSN0NseFNRL051RTF2cGROUkZyczFQLzczOUVFNVFQem1w?=
 =?gb2312?B?UE9tSng5d3NTWTVzOWVIZ2VOcFQ2dXF5a2tBUGNra0xuZks0bnBTb1FGWmZF?=
 =?gb2312?B?SHJsNGl5Mi9RYWhvUVc0ZEp1NWNGVFZrbVpUdlJuZU1LSmpJY2JPWEJZMDBu?=
 =?gb2312?B?di9oMUE4TnhJcVBQTkZRMVZwRWozNzNjRHlkRXJYYlVsLy9HR0FSQ0RJME9M?=
 =?gb2312?B?ckNaSFBua011N2NBSEVUdTJ5VXB5anVaT3FtaTdRd3cwcDhzRnJVcjVSazVj?=
 =?gb2312?B?cmZXZTRLWUkwTEpqK1JMTWtndzcwWjBOd3pYcmNKcHZYSlFkRlU2OXZXWEJT?=
 =?gb2312?B?RG1CLzkrMjIzR1VlZ2xMUUZEd2J1eEJteXo3ZGFmK2Nla21NMlpOZk9rMEIy?=
 =?gb2312?B?UXMzbkpmemo0UVhIaFd0YzVUYjhqUjN0MGdmMHNpRVFjZUplR0VFbXk3aE1v?=
 =?gb2312?B?bllLd3RwcE1JMGVVQVY5eGRwYUZIMHliZjk2THRZaEordTBncjRzTnJHeU9E?=
 =?gb2312?B?b0ZIS1EvaHp2blhYM1kramdYdnJzd05FNTdHZXcrYTYySmpOQ3ZXeHdvRGli?=
 =?gb2312?B?WTB5aU5xVWdtVkRFVUNPNmxIQXY2eVFCYlJ6ZVFBelFOTTFFUGZBUG5STTQz?=
 =?gb2312?B?UE5Hd3IvK0Ftcm9xTzJNcjU5TTJMekd5RXJxV1dwcjVod3RFVGJRek9mRDBV?=
 =?gb2312?B?aFRXQkVwY2ppck16VlpwOE5UQUxYTVVPR1FDTFVwaU9oL0VXWUR0a081Zjg5?=
 =?gb2312?B?UCtPUTBGOTlUUXZ1cDBZdFJzbzUvWEhxbEpvcGRSWkpFckxxZVhxb2g2N0Vj?=
 =?gb2312?B?b05pSG5wb2hiR29aczlKN0pEZnhYU09qeERkNnVIblBCVFljb1R2ODEyOUlK?=
 =?gb2312?B?SzNvTjh3aTVuZG9idVkrMCtuZlk3SVI5VWJQcTVwYmtNT2t4UythRDdQcjVK?=
 =?gb2312?B?N3lPUzJ0cmUrYTY1UUV5NDM2VVo2QW9JU0M5UXNaT2hzVlNvQXhlOTJCcStW?=
 =?gb2312?B?Z3U3L1ZZYkM3dThTNWoya0R2T0ZtcnNKckEvTlVBQjhZRncxY3JIdTkyVm4v?=
 =?gb2312?B?bzFlR3RUME5EZTg0QWxQTWdjcUREK09JRkx6cEpWSUNZb2l3blNkaUx0NnFW?=
 =?gb2312?B?ZisyTDA0M0doV0FYYlhuV0FFVVlSWVVKS29FemNtUk5PQ0YzWHcvYUk4RW1K?=
 =?gb2312?B?NE05ZG9jOEp4RXNRN3FpVFh3SjlRSEpnTlpRTmU2OURwTXRqeWhJSFJIM1l6?=
 =?gb2312?B?STR0cU1VeG84QlRneGxKVm9uVWFFenVHc2FqeDBKSjY4V1V3Q3JjbERzRTRJ?=
 =?gb2312?B?YTlaYjBaOUN1NEg4azlTeVdvc2laOWdkUDliczd3cjJNNytRdjRiaUNxZ2h4?=
 =?gb2312?B?U0E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3988.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d19103-cb42-459f-ff98-08dc3024a23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 01:55:07.8265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vad5X6ZZlH+ofhNzXAzi/pqJrjwezXrnjcIjUavadMBI1VGD8QYiZbWBlLUaQ0VySwZB/1URmil+udGu7HReI0XUTKuzNbdnPxZFChONS/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4896
Received-SPF: pass client-ip=40.107.94.138;
 envelope-from=zhaoyong.zhong@nephogine.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: 35
X-Spam_score: 3.5
X-Spam_bar: +++
X-Spam_report: (3.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgTWljaGFlbCwNCg0KVW5kZXJzdG9vZC4gVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpSaWNr
IFpob25nDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiANCreiy83KsbzkOiAyMDI0xOoy1MIxM8jVIDE3OjUzDQrK1bz+yMs6
IFJpY2sgWmhvbmcgPHpoYW95b25nLnpob25nQG5lcGhvZ2luZS5jb20+DQqzrcvNOiBFdWdlbmlv
IFBlcmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IFBldGVyIFh1IDxwZXRlcnhAcmVk
aGF0LmNvbT47IEd1byBaaGkgPHF0eHVuaW5nMTk5OUBzanR1LmVkdS5jbj47IFhpbnlpbmcgWXUg
PHhpbnlpbmcueXVAbmVwaG9naW5lLmNvbT47IFdlbnRhbyBKaWEgPHdlbnRhby5qaWFAbmVwaG9n
aW5lLmNvbT47IFNodWppbmcgRG9uZyA8c2h1amluZy5kb25nQG5lcGhvZ2luZS5jb20+OyBLeWxl
IFh1IDx6aGVuYmluZy54dUBuZXBob2dpbmUuY29tPg0K1vfM4jogUmU6ILvYuLQ6IEZXOiBbUEFU
Q0hdIHZob3N0LXVzZXI6IGFkZCBWSVJUSU9fRl9JTl9PUkRFUiBhbmQgVklSVElPX0ZfTk9USUZJ
Q0FUSU9OX0RBVEEgZmVhdHVyZQ0KDQpPbiBGcmksIEZlYiAwMiwgMjAyNCBhdCAxMDoyNzozM0FN
ICswMDAwLCBSaWNrIFpob25nIHdyb3RlOg0KPiBIaSBFdWdlbmlvIGFuZCBNaWNoYWVsLA0KPiAN
Cj4gTGV0IG1lIG1ha2UgaXQgbW9yZSBjbGVhciBhYm91dCB0aGUgdGFyZ2V0IGZvciB0aGlzIHBh
dGNoLiBDdXJyZW50bHkgQ29yaWdpbmUgaXMgZGV2ZWxvcGluZyB0aGUgdkRQQSBmZWF0dXJlcyBv
biBOSUMgd2hpY2ggYXJlIGJhc2VkIG9uIHRoZSBRRU1VIHZob3N0LXZkcGEvdmhvc3QtdXNlciBi
YWNrZW5kLiBUaGVzZSB0d28gdmlydGlvIGZlYXR1cmVzIGFyZSBoZWxwZnVsIGluIGRhdGEgcGxh
bmUgcGVyZm9ybWFuY2UuDQo+IA0KPiBJbiBteSB1bmRlcnN0YW5kaW5nLCB0aGVzZSB0d28gdmly
dGlvIGZlYXR1cmVzIGFyZSBkZWZpbmVkIGFzIHBhcnQgb2YgdGhlIGJhc2ljIGZhY2lsaXRpZXMg
b2YgYSBjb21tb24gdmlydGlvIGRldmljZSwgd2hpY2ggbWVhbnMgdGhleSBjYW4gYmUgdXRpbGl6
ZWQgYnkgdmlydGlvLW5ldCwgdmlydGlvLWJsaywgdmlydGlvLWZzLi4uIHdoYXRldmVyIGJhY2tl
bmQuIFRvIGltcGxlbWVudCwgaXQgaXMgYmV5b25kIHRoZSB0ZWFtJ3Mga25vd2xlZGdlIHRvIGhh
bmRsZSB0aGVzZSBmb3IgYWxsIGtpbmRzIG9mIGJhY2tlbmRzLiBTbyBJJ2QgcHJlZmVyIHRvIHNl
dCB0aGVtIG9mZiBieSBkZWZhdWx0IGFuZCByYWlzZSBhbiB3YXJuaW5nIGZvciBvdGhlciB0eXBl
IG9mIGJhY2tlbmRzLCBleGNlcHQgdmhvc3QtdmRwYS92aG9zdC11c2VyLg0KPiANCj4gQmVzdCBS
ZWdhcmRzLA0KPiBSaWNrIFpob25nDQoNClllcywgeW91IHNob3VsZCBzZXQgaXQgb2ZmIGJ5IGRl
ZmF1bHQuICBObywganVzdCBza2lwcGluZyBpbXBsZW1lbnRhdGlvbiB3b24ndCBjdXQgaXQuICBJ
dCBpcyB1bmRlcnN0YW5kYWJsZSB0aGF0IHlvdSBqdXN0IHdhbnQgeW91ciBvd24gdXNlLWNhc2Ug
YWRkcmVzc2VkIGFuZCBpdCBpcyBhbm5veWluZyB0byBnZXQgcm9wZWQgaW4gdG8gZG8gc29tZSB3
b3JrIG9uIHFlbXUuDQpIb3dldmVyLCBzdWNoIGlzIHRoZSBjb3N0IG9mIGRvaW5nIHRoaXMgYnVz
aW5lc3MuICBJZiBpbnN0ZWFkIHdlIGFkZCBoYWNrcyBsaWtlIHRoZSB3YXJuaW5nIHlvdSBtZW50
aW9uIHRoZW4gdGhlIGNvZGViYXNlIHF1aWNrbHkgYmVjb21lcyBhIG1lc3Mgb2Ygc3BlY2lhbCBj
YXNlcy4gIElmIHlvdSBuZWVkIHRoaXMgZmVhdHVyZSwgeW91IGhhdmUgdG8gbWFrZSBpdCBuaWNl
bHkgb3J0aG9nb25hbCBhbmQgcGFsYXRhYmxlIHRvIGV2ZXJ5b25lLiBJdCBpcyByZWFsbHkgbm90
IGEgbG90IG9mIGNvZGluZyB3b3JrLCBtb3N0bHkgdGVzdGluZy4NCg0KLS0NCk1TVA0KDQo=

