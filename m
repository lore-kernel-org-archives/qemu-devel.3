Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF364C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXZz-0005n3-DO; Tue, 14 Jul 2026 03:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZy-0005md-6s; Tue, 14 Jul 2026 03:29:22 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZw-0006WV-Ep; Tue, 14 Jul 2026 03:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/f8oBUzOSmgKcyBXWTppmXLGohY+s0qWy9Mdv8hgiPmzgzsaGI7BATpnfDsU+zbya6HDdxorrBjTsRqqT6iELmqAvozNAJSen2bZpcnOPcTEgQoyGZGeHpNlo8DWhYJ5ss5ZJpTvdu5CU5J4TJQojYiWIw8GGGaUis3UKAZbFje9eqxy9kItkV0X5hOLq/oufg75muXdsr/M62sdbjvyaUBf7PZkPnsGf4tp716UAqOduOHA9yzfDMnQCNMUNI8phLOFcsnIn0jAaEn2rE53e6tjhWEo5gxDdWVdSUBSqd19H9d0E3DwbiZBBhE4ZWnXwnQhmvQl3dMrOLAtQGs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mB/X1sLtCLXw4NUEl52xUoO6i3d2KP9FJ3Onnh6CnY=;
 b=p9zLuLqdz8yGJ1trvMxnG6+D6fMqHKk+Uc3FmKwVbXb8bAzMWGXtsKL4FfCTDYz6f4GKZgmRSWziqLxXLAWHnS56653hTccKR6YJ6icys+7Lj9g2vQMSsD1cTJy8lhmvMPm+/Xp6hqXe7IpdJNKVKxhDRYJDH7YsfTu3obTb7+KSvoqUd4xycE5Qn7DKLGtEF40prKvYdw2SYStybeKSMj0EieDj8Ve7trfgIvDCoYS0OOn7y3pW/06l2+2A8CqhcaooEk/YwrOec1+nameI2fmAvxp5v6jov5/9dpKqt+g2rsVCtMVTAULM8GhHdGGI/uc4UTnhayvjvUJjTbGoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mB/X1sLtCLXw4NUEl52xUoO6i3d2KP9FJ3Onnh6CnY=;
 b=SK3U/4rznUQvTUJ0FUY87wvOiPSpQhEEnANPGGNX6hTp57lru2svg8rfO6R4VzKXvxX/chdCh8RsL4+bvV8o2SaxiT+jQkIhzhXCgiktZQIWqFTNhTOTb2WC52WH/37BPY5Wb1vI84IxCreWgtd2feVuWbBiygDUomg5+5ClVYPT2ryXPvj1yzOydTc8w2QUceOQ41dg8jJGp4Ky4RsxHcSHqFCincrgWqwGlyiDQuR6rI1EvMH7GFt8F7MNjeGSLytp2EHKNtTQ3P9U8XX778Iapgio5hOF7IHhgDPHZPGtPwmUp+bIiVoSm21saTjLpURei/E8dqGmcQgWY7cw9w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:06 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/15] hw/misc/aspeed_hace: Support scatter-gather mode for
 the crypto command
Thread-Topic: [PATCH v1 03/15] hw/misc/aspeed_hace: Support scatter-gather
 mode for the crypto command
Thread-Index: AQHdE2Jz+hmGiS6Ae06EvHD/bqTxuA==
Date: Tue, 14 Jul 2026 07:29:05 +0000
Message-ID: <20260714072900.3023742-4-jamin_lin@aspeedtech.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: 42dcd676-37b9-44ec-35d3-08dee1799635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 3jXePj215uezzJxXN9zx9N1NTU9YhEy9EoX8/vg93EUV/or2Xwdktkpc0JN42E/11IjcnS8TsL1RtPacnp77csxq3P2EMlRF+8ihX0KDn35NRNhbthZwy3uHiho+tLOjC/LoSm74gsdK6NIZgytYbhAYuKlm9pxgTUeiR+c4AXgtCHx72/uCbhsyb8ttSozZnZCd5OV3MSi5APnlM2StfDs/3ipGryCNOQMGGYTfDw1Qal651uAU55WraBcyLOwrPKQTpL2kdS727jxTlrce9JJLHh2b/qUKkosOKI4qC3pc+6mEWrSxjAWxcIFYjjDoQJyaziRjH84dRocVTg8i9yLlut6GiCSkypfoSbr0TkMgUvhKv0GtARe1wIb+I6upD5/zk3EcqIp0dha6uDPFoKI1cweJ0dukOlz4B4dlLjVeXByWc736yRiA3cWWZQi7wTbOFVm9WDtcIs86aLV4gkLAhPbcgWBGQN6aeTk5KyXKttg9eQ/0wO/JEL28+rD3FFpqCe3X9lLo662WPECcl2GhbNTPBHFza1Dpa7w+/6KnUyg5lV9IyQ2JCXFTAECJW8XVepiTEfji8grkhG4N/CizoAlcsrOK43kbTU85MypIXVYcoF9VpgZU1IZFPAj1VzXJGG7RxJuF1pAP648U3oNc9z4Dh4ex35cf2o6riYWjVkHrDsndvzQxnwcy/NEbqSOo8r62pVrXmTiugZ/g2NdgfnKUopfldY6L3JE+Bn6M+8YFquMomjM6v4aSNvd7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tf8Ixwx7V5aeh65NS1flIfldvW/1ZifyE7/7rPhkZhO/CkJ2PaCE0/RxCH?=
 =?iso-8859-1?Q?sj3TrDzZpogkkGsgSfKRzowkIJ/Fkp36Nmo3lZOZ+eD9jsFkRspTe2Mt0n?=
 =?iso-8859-1?Q?bdP0KhVOEBxqmAXlnQTu57fb600Rk7iyhxnzVGyc05/yb+IF9aJD9QA+Pr?=
 =?iso-8859-1?Q?J/lQOKCgmMVkduT4jedrMT5ab5mzzgfH7BUWPc22DZv+nMdKpBVdQLzR77?=
 =?iso-8859-1?Q?68f5CPuZZ0JX4sEatErMRWw2//Zsl45YPJE8wtg/PJp9Hq3TRMCeoFQtQL?=
 =?iso-8859-1?Q?NNfRltYFsxip/8VuH6YccTHtJemZBxcwKLcT2QxyBuj4DeomAUtg2BsgJG?=
 =?iso-8859-1?Q?qRoKKm717KwYaegEToqq50G0A5h+XIut8QvUQFAn/qeQGvaFwhj9UUBeBZ?=
 =?iso-8859-1?Q?IAvPKan4l+fbHnNCtrX1VI6CZGIcFhZAMA+zgqx1vJbXQOk7Csdkdo2+UA?=
 =?iso-8859-1?Q?xuGWcMdJq9NZn2xWrgdympRIaApCuxHxE7G3hPn3YCdwy3G1a+ymsTUBo6?=
 =?iso-8859-1?Q?JaJJHY9v34lbqJ73L7ALb1UC28I+JdpJ/yUQ7R819vKidTn8znoSusQtLj?=
 =?iso-8859-1?Q?bCM/bctyCI2mA4vOhQxakqe9CsxVrsoOr9mh0e/XyAcpXahHsZKjm8d40R?=
 =?iso-8859-1?Q?J9PzOhZ18SP5S9FNBfggRpAnJs3XLzQ0M+0ZRR8SBS4MW1ZBZeMJPgjUkw?=
 =?iso-8859-1?Q?MgNadc1PLj4BIaakvH+f4QHvlTv/qP6h/M2BTqcdv6c74W0wkOoXaB7sdO?=
 =?iso-8859-1?Q?htU84T3qB2uzUKbtUfaC4aEpE+zK6IYJ76fXp5pWE/d7olZrWLaza76vFR?=
 =?iso-8859-1?Q?9D1DSWBAc//Jn5ERiZ0GPlh4RvN0ROO7r1pMzamhz1YR44wtabgvp3URFd?=
 =?iso-8859-1?Q?I7/C1EiFFndIcYFoQ77hqTjUL1MWPTk4vfc0TZhx2ig6yzOV3WtvQ42qaE?=
 =?iso-8859-1?Q?t7dtioqKX9Qkwd1ktb4RzJS8oXoIOqSiadnAXqzw3nQVBopSqSNeUAFb/M?=
 =?iso-8859-1?Q?SWUTF2XSpzdL8IGR/XVdXiSuEr/zWwgRDo9yt8XqONiJjYPnuZ6fo5+zHP?=
 =?iso-8859-1?Q?kKg+BsRlRnz7ij92vhJsjRj6Xq6x0GIelCPg6ow7AJfdINt3ClJ4hyB68Y?=
 =?iso-8859-1?Q?nagyKaprHZkOrCYUDGk1XouGUgasFxtjjS7kCsNa5xMrIuPUZoA4fPS+T3?=
 =?iso-8859-1?Q?ULeMeEIdHA6sQ/b8KEysKSX3VtF6G9XKo4zakLUNTvokZXrs5B8GH9i+lE?=
 =?iso-8859-1?Q?ltvyywH770oQkGyyGX18m4/PmPwshyFS85NOrV+ik+ruHJQq2BYIyie0TO?=
 =?iso-8859-1?Q?CQ+dnbA9hpi9GdHFz5nSY+0lZe7MG+Hnj8ityIo5CYxzQ+xclSeT7WV9J9?=
 =?iso-8859-1?Q?CChOlpiEz8rmG+HZN2ZOf3JF8cNn0LPRsuo+cM8+zK7Nkh/5TUlB5UB1WV?=
 =?iso-8859-1?Q?lqoGGc6NThUVKakDggDTgAeEIMBfFKNr7QCSFGipKtu4R/6TylvrCarO7Y?=
 =?iso-8859-1?Q?R2NSRbZl8JfgKAWN1CG5UCLg5qFid08/aD4tSIUrRxZ2x44FTrJBvw9yjK?=
 =?iso-8859-1?Q?d30AMaoMea0AzEKsnrBtfRrVKmbDO8w3R23bE3dLdaA2H39loEkIMDtx+m?=
 =?iso-8859-1?Q?72Bq4TPprDixQyojUyVnqI3T/7xF7lPUcsvDJcjvOLtoKC2sXX0WtbKqZp?=
 =?iso-8859-1?Q?C5cTYoevR7QDJtxqQx1TnOnfx00ai68WhIRXYuxlzJrTBABMvyHgiKvSS0?=
 =?iso-8859-1?Q?XP9d3WOOZrw8mGgsrGSGvfXUVu5H0lLZ+e/0W9Ev1/g+ZRm5ES+nNCIC/n?=
 =?iso-8859-1?Q?oAQMsaxs6g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iICdY6UJj5gxBiA2Ayo84d4wTkej+bJB7GAOLtR4Yg/S/dfQybJl/GqCaJ91gBTloddtxYaz9paEbug6O4PMKYsx/GVnP5tTeDaVGX/KT/IUySSNWWYL1glE+jJRJFPsA9YXENvJKaO1PhY67urKlbxAG2YJuZfLUOhlwq7xPpxmgpjLStTqhpEPd0Z3PsmbNZSOE8v+76VkUBqSBykdfaqxd+cDQjg1+AWlBQ9vh64eRQZLCVOGfjTjPH55isRAEPHwtdtovPmaoIIAdSiUgOK5f940IU2PK6ovREzvOWeODb7MU8UOLZ6zk1KOOWIaPInUV9du6EbGsIIYr2Z1Kw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dcd676-37b9-44ec-35d3-08dee1799635
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:06.0109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gj3rpixeHXO52g1LmWETyFqXgot4cw83nvFJKnMo61NPsncs5w6NWoB4zR0bhCK+CtZY4Lg/6RtQJ9Q+IcdzU/Ln7bBbkxa8n63FxZVK1KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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

The AST2600 and later crypto engines drive the source and destination=0A=
through scatter-gather lists (HACE10[18]/[19]) rather than the single=0A=
contiguous buffers used by the AST2500 direct access mode. Each SG list=0A=
entry is a length word (SG_LIST_LEN_LAST marks the final entry) followed=0A=
by a DRAM address, matching the hash engine layout.=0A=
=0A=
Add a crypt_prepare_sg() helper that gathers the source into / scatters=0A=
the destination out of the bounce buffer by walking the SG list, and=0A=
select it or the existing crypt_prepare_direct() from do_crypt_operation=0A=
based on HACE10[18], mirroring the hash engine's direct/scatter-gather=0A=
dispatch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 70 +++++++++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 64 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 42d8b38be3..59eb1aeae3 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -610,13 +610,58 @@ static bool crypt_prepare_direct(AspeedHACEState *s, =
uint64_t addr,=0A=
 }=0A=
 =0A=
 /*=0A=
- * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the so=
urce=0A=
- * and destination are single contiguous buffers (HACE00/HACE04) and the I=
V/key=0A=
- * come from the context buffer (HACE08). For CBC the resulting chaining I=
V is=0A=
- * written back to the context buffer so the driver can continue the chain=
.=0A=
+ * Scatter-gather mode: the source/destination register points at an SG li=
st=0A=
+ * whose entries are a length word (SG_LIST_LEN_LAST flags the final entry=
)=0A=
+ * followed by a DRAM address, matching the hash engine layout. Gather @le=
n=0A=
+ * bytes into @buf, or scatter @buf back out when @to_dram is true.=0A=
+ * Returns true on success.=0A=
+ */=0A=
+static bool crypt_prepare_sg(AspeedHACEState *s, uint64_t addr,=0A=
+                             uint8_t *buf, uint32_t len, bool to_dram)=0A=
+{=0A=
+    uint32_t copied =3D 0;=0A=
+    uint32_t sg_addr;=0A=
+    uint32_t sg_len;=0A=
+    uint32_t entry;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_HACE_MAX_SG && copied < len; i++) {=0A=
+        entry =3D address_space_ldl_le(&s->dram_as, addr,=0A=
+                                     MEMTXATTRS_UNSPECIFIED, NULL);=0A=
+        sg_addr =3D address_space_ldl_le(&s->dram_as, addr + SG_LIST_LEN_S=
IZE,=0A=
+                                       MEMTXATTRS_UNSPECIFIED, NULL);=0A=
+        sg_len =3D entry & SG_LIST_LEN_MASK;=0A=
+=0A=
+        sg_addr &=3D SG_LIST_ADDR_MASK;=0A=
+        addr +=3D SG_LIST_ENTRY_SIZE;=0A=
+=0A=
+        if (sg_len > len - copied) {=0A=
+            sg_len =3D len - copied;=0A=
+        }=0A=
+        if (address_space_rw(&s->dram_as, sg_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                             buf + copied, sg_len, to_dram)) {=0A=
+            return false;=0A=
+        }=0A=
+        copied +=3D sg_len;=0A=
+=0A=
+        if (entry & SG_LIST_LEN_LAST) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return copied =3D=3D len;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
+ * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
+ * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come fr=
om=0A=
+ * the context buffer (HACE08). For CBC the resulting chaining IV is writt=
en=0A=
+ * back to the context buffer so the driver can continue the chain.=0A=
  */=0A=
 static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
 {=0A=
+    bool sg_mode =3D cmd & CRYPT_CMD_SRC_SG_CTRL;=0A=
     uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];=0A=
     bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;=0A=
     g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
@@ -633,6 +678,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
     size_t keylen;=0A=
+    bool status;=0A=
 =0A=
     if (len =3D=3D 0) {=0A=
         return;=0A=
@@ -679,8 +725,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
     src_buf =3D g_malloc0(len);=0A=
     dst_buf =3D g_malloc0(len);=0A=
 =0A=
+    /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
     src_addr =3D s->regs[R_CRYPT_SRC];=0A=
-    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {=0A=
+    if (sg_mode) {=0A=
+        status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);=0A=
+    } else {=0A=
+        status =3D crypt_prepare_direct(s, src_addr, src_buf, len, false);=
=0A=
+    }=0A=
+    if (!status) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx "\n=
",=0A=
                       __func__, src_addr);=0A=
@@ -709,8 +761,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
         }=0A=
     }=0A=
 =0A=
+    /* Scatter the result back out, per the selected mode. */=0A=
     dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
-    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {=0A=
+    if (sg_mode) {=0A=
+        status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);=0A=
+    } else {=0A=
+        status =3D crypt_prepare_direct(s, dst_addr, dst_buf, len, true);=
=0A=
+    }=0A=
+    if (!status) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, dst_addr);=0A=
-- =0A=
2.43.0=0A=

