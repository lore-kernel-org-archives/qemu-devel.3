Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85515C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYR-0007KL-Cs; Tue, 11 Aug 2026 02:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYP-0007JD-Bh; Tue, 11 Aug 2026 02:01:37 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYN-0002cm-Oe; Tue, 11 Aug 2026 02:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZb/PN0d6WwEWAanqb9+u1x8+j5rLJK2M/XkTfiC6OW4qn93W88t+DKgf7im6h3WLYL9xXWG2QSYwSUl1Bk9mi9PdWrSFHqumrqkcOKEtWqTnjxY7CEw5MB9eSVBt8aVab+PylueHLb417c1jPq1nKMIGtfwfo/AEzXjI6R8fOevvU45YTgnlC4qhh9CfyReHlkGyLfp3qzK1AJatfx04CNBtUzug1m/jlaxQUv5LAzpAy6nbckHQtliciX6ovwYe2Ywxw+15EUfWj7l4PfQ/AyxKzgdfCODsVHRRfrZaqzENJeSWBSg5lEia4mf3VeyplUDVS1zKeS3/269weOriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LFolXsfMVOx0M8VqCpGsRsi7J/g1G81o4e6Y5onh44=;
 b=s8BzH3cF1tP1/B59LGOFKc0yTCloL4LxOKAaxtVId/AoyA9c6wxebpctS6EdiapnU6gpS/pHRG9ZKMih+88aCVpbkQwx6Wv0zv9lBrmMyrdvT61szxnlly9br/QDNjcBgZ0jb0iyufEvmFJNr702E9IHEIlmy4t2SLDP5i0COfAaWM3F/c9b46pTMx7Px6fPjl0DZ9vTNKk7Q7lLUazcucwqonY05ekkMVYLqOUPWDP/D/9xNCcpCy10Nzx9W5EGJZ5IZbLbgeoIHoJ3hs5bE8ZCujgxI6MYjU7qxnfSAvze6OX8MbQXhBeccjf8YJpMj9L50W6Atee8Ykkb/Or3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LFolXsfMVOx0M8VqCpGsRsi7J/g1G81o4e6Y5onh44=;
 b=EDbzcE3WSVPE5kHf2nQ9frBCVxgaFzH1s6svy6rq6JnpIfZpxVpZ9Qk8RtXxCC9Ek+Ib2Um5rYz/zfomnl8+iS7Jvj9OG5M8elrl1VpOBAnOd+BeugG2pafs2Rb/v8j70JF88yDBkQBytpTXjkZFZtsap96rCk3VHctqwFe9IJJXHEHwxe6iQB3X8UwleBeZ9GkCys2cUUpl5d2qSotdmTeSGnQSxHk0BAEyz7LLRUKFNk7dPAd9PrVvGb3Ti6LK55NoFKk0tNUfYN31laSlLb1y7qg5BRVGuopXV4LuJKyVVz885hUyiwZXAF17QeuGvIDs+PPdufDbEt8noQFLfw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:21 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:21 +0000
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
Subject: [PATCH v4 03/16] hw/misc/aspeed_hace: Support scatter-gather mode for
 the crypto command
Thread-Topic: [PATCH v4 03/16] hw/misc/aspeed_hace: Support scatter-gather
 mode for the crypto command
Thread-Index: AQHdKVbVNRoBdtnkUkCfKDYcLLKCfA==
Date: Tue, 11 Aug 2026 06:01:21 +0000
Message-ID: <20260811060115.1849266-4-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF7489084AC:EE_
x-ms-office365-filtering-correlation-id: 32c51884-b437-4094-f485-08def76df79f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: h1nOUx9ZxU8jXIWz3etROxm5QAipvNp4miD/bySocGcxeB2qMuBnNCeknoXVD7svj3R4MfBojJKhjBLdymTE/sf7eyBGyvUmh7/x2QHjxUtoHrPLepb31mH5VtRHP9WR1BUJ7f8+Ja97YPihMjWoIeW0zRMoBMiYrhkDf5ZkD+0W/GFo6Ko/zOA9HjEoWuDhcuAsE8Uvf4HtaHbNSIbZRYLXjQO/2UrUUiSt3WYNh0H6W7rzXzb8Ij159t12I/vBeJCRMVlN97HJTDW7t0BhdzK9m4SrBVAKB2INQNKSUOzdjyApyjiu60mJey/m/Y/BG3qgXB5KKaSzdFTs93m213eMyeQsie7RloE9Xb9rL/rn9mdKAuokY+RyxQWUI4LMTPi6WHnbD5kwNLqglrY4Yxk5i5/Bldi2g4AyF8X5tJjcGAfJs1LAUBxPSI4dl6q/lcdMwDEWFmTLXrlV943WOKr1Me6mtd5vW6Pvsfgw7ObXHkSqq3ivrTEFClkg7jNebOvUxQkZzuSNkuHGcCvs+997dv4hTE15m82V3TFIfXrqHMfhTglxEp9zcgKya6r70trWi4loT4CjL67Z+T6NH8Nmf27hqCSEkeICCMOB3GvctsiUyuk4sYONlUwCcZvk6Sq70b1P67Up66XOpg1F6Ra+N3tWFBywgctt10R209RFwW/bN90tFunY7FQY/+hK19LiTr58djCwUAJL72SS8xyGQ09wUjIc84H61ZfdU+2Vv5EQ8vpkdmsJ3vfAzhKX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Syr6u7dpDfYIGELUBT3FH1LP6t8tu92XL/si7v8YJWVZlx+0oOJxylHeWi?=
 =?iso-8859-1?Q?qX2kgOam7YLDJPih2RnwkVDTEZfO4sFeg/klqOtzONVB9SZxMsw+Lg16Rf?=
 =?iso-8859-1?Q?PqOWTmk2gbi52XevtL5LRe/50YUUCxcPWUkq5Xq4NS+08wuTBAcsbLHmTI?=
 =?iso-8859-1?Q?aYGz0s7iULizJ85PtA3xuBUMqa+btgmGn9rtFI9YJI1m+9GvbXGVRV/ocf?=
 =?iso-8859-1?Q?/yF4qZ+IeLT4TVTpllU9QU2aZlfdXobgF+NMabVCgftMej8fuL6vbjMxWq?=
 =?iso-8859-1?Q?tM226bPqnj8y0jqOaSvG8veRIYr98zvuJpTg5fERIQXeTv9uriyCKwKtI+?=
 =?iso-8859-1?Q?rbudd00CyBUo3ahOzLq+xUW2OKuFjw9Sm7sGUKJ71q45btnzwNsrtI4hoV?=
 =?iso-8859-1?Q?zT493qOii22pHnVNtqeWxtwnudU+FwA1kwHfgkU6CVhLQ4C0YAxHtt8z3J?=
 =?iso-8859-1?Q?QdnFUBgxzLpF0EtCvsTMoYU5stxN7WcveWLHzePVRkSUkRKbJRQaSDWBsl?=
 =?iso-8859-1?Q?t69jMvrckHui98x62BSgaD4S/cT9f5alC2MWYaIwT7ZOK6ad09aBld1c7s?=
 =?iso-8859-1?Q?xurj9QpgRHN32kbJrBhtFSXxoD2wKf8aThbz0nKyHMZj5YhyE7EpBgReAX?=
 =?iso-8859-1?Q?qoJRFiFkz+iCD6+zUnO6VwX0KIteOEJkjNq45r0tIIJloBdcENU5uTHCb6?=
 =?iso-8859-1?Q?QJcJ6s1KBzUBZeQM1dAYfsatOi4JhXWSUmil1udtyK3pw95jiK5BQaXDvr?=
 =?iso-8859-1?Q?vhlKLwhZ0UVKtzPvGct+Oz8kaR8D8sJZMxrFWScLjK/JDwhAB9qY/HhLl+?=
 =?iso-8859-1?Q?Q+2xtaxKyqPa+sJYw4HdOn3i8Liz/ygexrrEik+8+qq5NR5Qh19SA6W6dJ?=
 =?iso-8859-1?Q?BnRJsr5pbQLZAPJPtxDWk7b1gFpSVbbtpw/5D0dw3REplgqKDwe+1qjksF?=
 =?iso-8859-1?Q?nJrwlYsTvRmH1Wb1/z1/cqiwLu/X0Zu1yEwEshSWVic7ZMzcC/VNsLPyld?=
 =?iso-8859-1?Q?hSESPM7eW6uqavZvw3eycIKjZmTI1q0Q0VnlfDIqm6P5LxQaFRDLERqaHA?=
 =?iso-8859-1?Q?KJwcPK07k5XYXyuvfWJVlfmDSvPfLrpz0MPQeIbbyFkc6W0lfeX7mSL3hX?=
 =?iso-8859-1?Q?ukxvRwAdDtsFkAAgtG1AUSutLGDtSzcsDO2wD9uh649kcJI62GUiLlPbkF?=
 =?iso-8859-1?Q?y+nhVSefEAYF91MrAAqVxLhTQHXqkQPrvWGYWiQl+nS898BsC101Ac9t7A?=
 =?iso-8859-1?Q?3j9+ek2uoABWMEvIw2HDHwO/am0NrmRDE02K8b7/U9pvPa02H0pdUgH9ZG?=
 =?iso-8859-1?Q?/gzENgCMyLxfDh3uNLPG/O2gKXK7PkpER+zfznD4oNSMbdIpc/MkrrE6d+?=
 =?iso-8859-1?Q?95/4B5srza0qspuwdM9RwPKesYg65j7vHw7knmTtAJgwu6PuqAl1lBvFp0?=
 =?iso-8859-1?Q?amquCcZsIaZMHrbzokf0kIej+1U02Uofz4uUbAVQb9MVXMEMcVHrVD1VTP?=
 =?iso-8859-1?Q?qQl605gegjEShGwsaoLEm0JsnsphxAWtC5s6vX/EIyaMxkfE83KzovQJxp?=
 =?iso-8859-1?Q?idWFE3TCWDj0AYwN+itB5vhrZAcYxdvtiZfCJgjIEdIoBWhonYkGNMebSu?=
 =?iso-8859-1?Q?wOM3x5+A1YGKSByRfKdG2mMukUD4fD3yZNWJyjDZQcmTHb0DNkmNjSBroD?=
 =?iso-8859-1?Q?999BJ5W0e4qD+Tk3ZCVLDZ8G5rTkoHxN2D44ZFoWdhKK9SmB+1l5e/c6dq?=
 =?iso-8859-1?Q?1+C/Ccy3DSX45BC4aiNT0CqhijieP9dp8Mhymgd8h0lTxJprHJSEgMfWqF?=
 =?iso-8859-1?Q?ejZyGtDmwQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gaTzkqLy+FWV4mtStqrN9/pxBmIf3Vu9N1Jg2B3Mbr6Oh7q5/skT86iDkGa5ioBo+k4REG7Wy9iOXlBSGKqpcW/7TBKoZTPKQL5T+9gdWsX1r2vsveqPrXqitAElMa4Mmt7+MPVMEPREKkW1GLvxRxrCWEsddLdgVVaOeshOjDusOOpX6afXzKHBWt9K1CBD6TnaibELEYdmMpXtZGjV9+GbYCd/QjE38Wm+dgRtJCvx75A/13+rDT1S3/JqRrnJ99UI+U75dfA3K3DLJPpieR+iOcIhjSM2aGewcCamwmLxsKsBHKO5c5FIvVUpG1P36NbcPPk6zMpCtcjkZMUHSA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c51884-b437-4094-f485-08def76df79f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:21.0843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeC7JkKhbzbqyUlQhVLQPrFARkGfr4iluj9LCqeyD7sK2/5+1HzvBTp7Rql3g0rFMpWXIr6BP0gfK4RirVx+8cKzIsqLIytcZEKHf4Ls+AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 70 +++++++++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 64 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 0f35d74137..646ff50476 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -608,13 +608,58 @@ static bool crypt_prepare_direct(AspeedHACEState *s, =
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
@@ -631,6 +676,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
     size_t keylen;=0A=
+    bool status;=0A=
 =0A=
     if (len =3D=3D 0) {=0A=
         return;=0A=
@@ -684,8 +730,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
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
@@ -714,8 +766,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
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

