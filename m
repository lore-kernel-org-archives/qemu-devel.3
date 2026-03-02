Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0DAD58E47
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwtvj-0005qR-Fi; Sun, 01 Mar 2026 22:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvi-0005q8-LV
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:46 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwtvh-00008k-Bd
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:26:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkOM5TLAh3Jsbb6ldtj3V6KQkQpF84OQGBLbCJiVSQECbrcq5BFdCiXF3ag8mL9OlkG33gJ0Ok2FhIzbhX2h/St8Sv3uDzJ+p6INNFGYS8bWWf5Ee6ahx5AspP0/wwQaRzFgs+fzD9YdxN4PfqGnnrrdL2VeT5ANh/Xr4EBvTtTXOAwUxrcWnfYBtBNahIGo27HBhR8VyY8HTDtag0tW6DEL5i2omApaEE7SUXd05yGTvPbMY0qdCY+ei0nuTzoD+FCy/tkWRdU5qpLNxbvMxXjuo2UAqZl8ddwqZGHGjWyfmaA8Mmzxx56KfIjYLZ9x2L7gwSGwU64SnTekLQsXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfPOyJ7rwGhSpbCThZcKuYFglX31pHQDzhA+Wa3Qbbc=;
 b=rxLdLilyqz6tf/MUFbYfJwl4amwK0smaEf9q6zEhx+TXZL5hWYCElmBTMG37962UzzJpxGKyz+kTEkr5iEARHD5OSjN7yeXV4gC31SCNMFFAVhnyxFCIQhundVqRcNj3soTbsx72S/mg/UpYFGPQIlfE0IavklOqgpw85q6jCraj+y3R6IUSwqDnu8WA+4fmJoS7rGDyG2NIMJZdwo+l/95wnLtyF6oZiWD6+sfDufgO6/yX4PvsQ8aLOnczbCBdkR8KWOqfc8mIOJPAr9DG/5qh6CgdUOtwcCRQlLje8gMOHB8WR4gGpDJpLccL5bSFCXye61sWOORM9TsF4Ux7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfPOyJ7rwGhSpbCThZcKuYFglX31pHQDzhA+Wa3Qbbc=;
 b=JFgM1PrJV0F2VSTLTumghAXWdaPpE7cQ6+JOr2UeuyvgKz7G518J8fhLvV+8DQVkNgo+5pxyp5KOLrJ4crsG3DQytLXBMkRhd78WYSyNuAoPcKBs54+WGMsjqwECefiy+ZF0ZqHzML0CQRCn1pgAv7KYhkxUKJVvh1m99nPe3iJQQ/NqwSlqQPNhQeYJUCVz8gmp0GuXwsNfvrcNJ5laUBtYNim3BVrqna+02tpb8uV7fz+OAYRYoYV5bth7lJsEs1bcG8+W7eKrrJAnRuuFm0cHdEXyHvLgu4jwgDa6/k6Mdx85bkF/im6lK0WbEOyOmNhXg2UiE5nyddXBjRuerA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6791.apcprd06.prod.outlook.com (2603:1096:820:ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:26:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:26:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "jithu.joseph@oss.qualcomm.com" <jithu.joseph@oss.qualcomm.com>,
 "clg@kaod.org" <clg@kaod.org>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 3/4] hw/i3c/core: Initialize num_sent in i3c_send_byte()
Thread-Topic: [PATCH v1 3/4] hw/i3c/core: Initialize num_sent in
 i3c_send_byte()
Thread-Index: AQHcqfReXknTiWVv/0O869EwyzNeeg==
Date: Mon, 2 Mar 2026 03:26:33 +0000
Message-ID: <20260302032626.1974743-4-jamin_lin@aspeedtech.com>
References: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302032626.1974743-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6791:EE_
x-ms-office365-filtering-correlation-id: ef0fc2c6-ae26-4465-1dac-08de780b80e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 0/qmBqnISRYkFAxk75qdF5McoagOMzOwbZlFFnW83YN+hWffncib1vrKhD91lGmfflzSLtdRb3pgT8pcf5RJkHvoElkp1r29VjqLSIv7cYb8gU5fRQY1nUAoty0rF3BjdhWUz9QoMSgCX186s0Yz8WVoIlHk4E/Ad8Y4atCi/b1MFfYizMNqlpAnkpa8Gtfvofh3pvNxzrORS7PvUXoKLaltrX/PA4XDTMYbqEtzBvr354+OtR4O8c5l0OGn6rgRCtF7HTbldjRvsXRTCiHapeVhLGhhwHmPKy7IfYCqoZR7nxjH71/1rJlucQXMy9y3ekMoXlZDE/igd34Pjdy9vun2gkh8HpVFZJtygO7mUb8Mbv4lIP8HvcAJw8v5WwkqxvljC1L4x6IHkvkht4EoIbb1Z+q6+67JVEz2zZRXitPz2FXvbn2gqX5UnAterYJzCx6AiPbgp9wyUV5eWuB0rQU97F1urHQF3fwQkWw0kYyQq9VXfD6UKhAi/dOFogBM2/pr1lQhoNAX5U8UxCaM4qwIKIWqrXAyz3rBBYkBzzvKOePFUrAdjQWLJGopVEc1REiSov1SmH2tV8hG+OvGLyMXsyMrJaIRbN5XGiHiftZDWTYTRA4IEXJACn3mTOqO37Hgz7U+edYnouZrgspHW9f4cIDQkH0Tq0bXh4MBd8lvSrtHPPO81bI+T/DslCjzA4C9W82zM7UFqwNv7kThk2rdut7mSBBV8xnD3F07KYrG4hKY7U6RdQRRAptivlYXQUIv6Yek5L83U/OmVxPC4hDI2b+T9JbyWb+9ArXNwoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUJXmBr9klQGCfPwKnNe+5djIGyesQrSxbMF6x0XGLqQctWBKNimATbHUY7N?=
 =?us-ascii?Q?k2JpnvNmeaAKGh/zOuQvq97IGBdmYADpaqSB1rJEX4r95vcB4LKU9yqrkm7/?=
 =?us-ascii?Q?yhDMxjqVgGoZ3B7sKRt2VQ7HuKlDeWvrsogZMyzZszCaT4f3E8cyb3iLRmDG?=
 =?us-ascii?Q?ArnsCvFZFU9urFUY3muc4ZoOeUwSc+R2l+vHyBfPboB6faMIb1I3dQOlh7lA?=
 =?us-ascii?Q?i80j6Clr7xALA05y6ZautH4WUSlNcL6KQpdjsU6VwOXxlbOMePNUMlcwjbo8?=
 =?us-ascii?Q?HZbxNSxYCrPm/pIdkfgaxgIgz/7zyH0cQ+5R/mrwHNloqMTXIcjLbYcS/e8N?=
 =?us-ascii?Q?V0SwM06uQcU7kJr4PIa5Xf5BbSG5SUnJ8pcU9npOUz1IJGCXaLon3A7tYIts?=
 =?us-ascii?Q?YuI44uAbVFt2F+bIooFQzq0uT67afa+BqeMsTdfgV4i1ne3An8oNLeDn0DUl?=
 =?us-ascii?Q?w4xiWu7mf0CnIXBCKYoPrJzxsH458R7DMlEmJMmaPo6tVaMgm6DuP9tkxw/p?=
 =?us-ascii?Q?zOEP3QpgtCLH+LYQ2/ov6aB2szSdM151HoQrhhJeolxhn4NSbRfbNfulayMI?=
 =?us-ascii?Q?aN+OuJJbjroMRDre2aCfFXm+vs2I+cNGH79C5cQkcrZmOiH4cQqV4Iktbkjq?=
 =?us-ascii?Q?YlJQUZa5CuZZacLsIwCIQzCnjv0jjsH37o6C5T/KwqqjunpwLeU8+uwe/ivz?=
 =?us-ascii?Q?FxJSCwUMl4L7hG20RoT7eRnA6NJedNpK1/go4Ke5F7bd52WhDUfpv9qdXz55?=
 =?us-ascii?Q?7ZOV71g0bLObxefFnSOjpKi7mGhUHbQwUYJYCGZx/CfxzXUbE1H0gd/vtOTj?=
 =?us-ascii?Q?1UEZqqDK1OTOyQbiKKpfqruuYIB+TPZdjR+dCmuP2ANqAT6DizX5OoTFeTVw?=
 =?us-ascii?Q?IshIUTiw4tVOnZHdmT1ts12Sv0JcS42HLzU2tIFU90C0ZmpqMqSiWnlIXvq1?=
 =?us-ascii?Q?OJMZYhm6fmQcm40trTmqWZQ9JIyWdrCUF9AiamHt6EmHHaVUZk9zC1n/K5uk?=
 =?us-ascii?Q?b1/wXo18EA6gqKwl9GTM1NsOpgg8gK0RQdc3eQAOCBWcYPkO5OjYEVivy9Es?=
 =?us-ascii?Q?TR4CuRMmR57zmoCnirWFirt0wshCjeuz5jdWbCEcwxjx77cxYtiZ4QswDuNA?=
 =?us-ascii?Q?4MlxggUBdr+NHXLi6ublR/Diu0/YSfJTK1GWJnEQuAU7EbNxSLscxeHfFrrO?=
 =?us-ascii?Q?YDb3JqJ4jAcu504iH1fJAXq087UXkYYSAs1UOhSxnuem4hO8IVIzXSn7HeAU?=
 =?us-ascii?Q?zSFdIVQBOvlYzooGuskFhxtO/pVcyFOfEYprPS2ygZhbtrTk3pmtjaVVyNg5?=
 =?us-ascii?Q?CfVchUCMpnfgU0YMNZq5GH88xO+L4zrSszJhmda5GXfrX2WtLKP5zSk0rH2i?=
 =?us-ascii?Q?lDB+Hyo1h/VKtbitWJ/JhSbj1KlKoAmEhtWfPdhSKHIdHfR7tN6MSI+5oQS9?=
 =?us-ascii?Q?RwvFAs3Rp/xnOnhRgjpFgOMxMPP6XPEhM/2GwfgUBAE2iBHU+sY50zV3Ja8T?=
 =?us-ascii?Q?qPeEJ6NSnHc1qtugBa6j+Prde6L1TXOVdUY7UdTRsxmIqHttk+csRsgwGIIL?=
 =?us-ascii?Q?B8noTG4iqs+5tpg8jvPwB+ZLh7M5VJXRbwILUKNB+KwCKKJBbEOA+8nRMv1a?=
 =?us-ascii?Q?2+ltN2cBwFTpbRcS+O5Mz7vyjjFbDkwAWWi0MAEcjI+GwwR1tjs1vabBHo9K?=
 =?us-ascii?Q?9CvPuKoaBs1zy6Xux5oKKJ9PoQEwqOFmBpzzegTfYr5IT1/kkhhpgEu2VL3z?=
 =?us-ascii?Q?vbRdwwX/eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0fc2c6-ae26-4465-1dac-08de780b80e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:26:33.4754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKFU1f3zLPheexlLzAW9SQLULRcb3dzXI4+1d3N2c298UVfLt+Cy2bOHpWjNphuphf/Txs1WIriW0+GmI0rtkSpnjVB6uEDUyXlJzJy+/h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6791
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

i3c_send_byte() declared num_sent without initializing it before=0A=
passing its address to i3c_send().=0A=
=0A=
Although i3c_send_byte() itself ignores num_sent after the call,=0A=
i3c_send() forwards it to trace_i3c_send(). If the target send=0A=
callback does not set *num_sent, the trace may print an=0A=
uninitialized value, leading to misleading or garbage output.=0A=
=0A=
Example concern from review:=0A=
  trace_i3c_send(*num_sent, num_to_send, ret =3D=3D 0);=0A=
=0A=
If *num_sent is not written by the callback, this trace can report=0A=
an incorrect number of transmitted bytes.=0A=
=0A=
Initialize num_sent to 0 to ensure deterministic and predictable=0A=
trace output, even if the callback fails to update it.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/core.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
index 0a266e00a2..168526003d 100644=0A=
--- a/hw/i3c/core.c=0A=
+++ b/hw/i3c/core.c=0A=
@@ -325,7 +325,7 @@ int i3c_send_byte(I3CBus *bus, uint8_t data)=0A=
      * Ignored, the caller can determine how many were sent based on if th=
is was=0A=
      * ACKed/NACKed.=0A=
      */=0A=
-    uint32_t num_sent;=0A=
+    uint32_t num_sent =3D 0;=0A=
     return i3c_send(bus, &data, 1, &num_sent);=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

