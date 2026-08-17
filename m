Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B47EC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvqHu-0004Wn-3s; Mon, 17 Aug 2026 01:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHs-0004W6-1g
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:32 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHq-0004hN-Gq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATNQKT/yciJmPra+NdppadUgsG+wa9lEjgnmGnOrDt6+5gyQoczc05xgqThcobFQFdeeDJpYkx2SRF/agXZPkSGsrif9KI3XTdE/tGOGMypH0wMkYLasjq1qm73rgvM+Ddz9neoj2ha1jrYaAkzlV5O/1/mQXLjWmoByMMyYPFDl8+nmN+Hq3OWhZXzLMWNYtjS3eNPDo4UoC5a9QUkceFkgCUzWpgxnKbsk2cYJpQtNBzGPqwdewEnX5EEqISHj/M0c351ftJtW+DDos6GV4CxBibDklU+CotStlrZ5u9gVQE+lfDEIxhup02jViL1eFLWcaIQPi3o+YH8pfSu1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DLeXM+G1qY1bWjLPPwjWyDiZl8GD+QWTkJQU2inY3I=;
 b=E/fjAsrUhRqtdYsBMrlHhotiYvfz98nq0M51DXVudtSfZmoHg/rcRZoM2OWLx3LbNWcuPxmvBp7axSWmPPKojf4fHQixkNEY+eGAzl2Etq9n4Yiqy6vg42TMW6NDhMvdPOgKFi4TJsbRzfib0cwO0owCcZe/ygd4Yo0GzUbjbBnvsixe+lvmVyPkMzsRh9Utqb42kwUuNbYKOOtmGtq0kbJ3rIQIJkN8tNhByI+zCVImp3Ecbt9BHXMFYMUoRAxdj89BQMuyspJ57/cgvxGK46KBw65RYZKofQF+tGyDxvoG2H8kPn9cTN3gAs2DgGlyew5m6UotJSXcbFitmihXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DLeXM+G1qY1bWjLPPwjWyDiZl8GD+QWTkJQU2inY3I=;
 b=GVymVjlAGIaHgNxQFxgMo4EKQHfx/TXlQ5v3ppZRM8jsMAiLxcshTSNYm43ed7XZEXENVxvxI4nqd0tR+q7dozQ5ZmQBqCm3L2PxJ3NXz2WN2HeEaIG+YOAKnwe6PbuwN/SetRij/LUbAJQo4JAaDaQ45UX1607LuWhCo7Ex6fjkB6H+gPxISYrw5zwF/fBIl2lF2KfkdZve4vP+3KL3D8G97jkrd5J+WLx9w66sommygOfuKbhJN5JnwZkGX5zUS6o3sg2MApk/Bssg854AyKlKMypvXM/st33cVcCJ4uTCYlsbg073oxf1AYB8LOY/+HdJKlKlhldFdh0OJ8QYAw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYNPR06MB8880.apcprd06.prod.outlook.com (2603:1096:405:3c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:53:21 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:53:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "clg@kaod.org" <clg@kaod.org>, "clg@redhat.com"
 <clg@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 1/3] hw/usb/hcd-ehci: Check for DMA errors in
 get_dwords()/put_dwords()
Thread-Topic: [PATCH v3 1/3] hw/usb/hcd-ehci: Check for DMA errors in
 get_dwords()/put_dwords()
Thread-Index: AQHdLgy1biN793ldtkyOFv8LJrNurA==
Date: Mon, 17 Aug 2026 05:53:20 +0000
Message-ID: <20260817055318.3826428-2-jamin_lin@aspeedtech.com>
References: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYNPR06MB8880:EE_
x-ms-office365-filtering-correlation-id: 892f3624-6419-4fb7-4403-08defc23d7e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: IC7m76xhnWXPrZae7KPjBghJwGD6WPGuX4yJiU/4admWpNfkC4ecYZl0bqlI5LTeHd2TWP7lo3iosWZVcmcSI/OgntY4PZwXsPtnq5siPNH0yMt1hDEuKtNnE++EhAa5Fr1Kaq7XSp9+WUJ3kKM+A1Czw4efn9owUgF3dzUplZvB1tqk7qZI7sWwZcXkAgm3u4XJSY/IxCWb2cxYEThvi30O47rziLyrs3wK53N/NxI6ZP2ivbvkW4eOL+Kbs7XYdjhnsIbZx+VTHtcybXSTPJXmnHm0XrEH89Dzz61H1uXizc2K1FzazvW/4rM26ui9Qe3ZfZOShYD0o5jkM61808C7Aw3arTOSn/sthoF5yS6Hz3v2OzNXQhRhv3DdIt5QAfmyWCxWFYPlhmG9DUajjnvzWqtlajCeGKyIVipa364bH/4EJMDrhLeTSM632BuImnpNTr2O1u9JX+WUX/w/EQRpIkm+Jd44gfh/FBOMNLb6EynT9Nxoio0uOzQK4CWrDR/UxkUfizvuxGr/Z6JNxhcj09Km1Cl+N+ouGokO5jWMXq07CKrpCQtxsGXiFEED32cVQf5BSP++XHCtXnl95b3NovWj+bsk30+uaV8gIHaH66dzsJqepd15Hztf4TeO6HB+/HOBfod0UHshjUDs4fy5mZJOIGWKGezZWQPKbfbJQbw31LdRh9XweJqKOKMPKtNQ3/u2ufH+G8UvS7UJT+8P4W61euwBSF/dPGVrdMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kkfV2LK7mzxgewveGyE+WPADznDLT5W1RcDi9PtMKe0LBJUYKN6erf7qnn?=
 =?iso-8859-1?Q?ld0FMIL7s35iZ8TUZd/SBOhNmRpwR+DukkU6E8BMPLtBGJs7SEBpfZSR+k?=
 =?iso-8859-1?Q?7tyv/+gBUm4JxeQbF8DcYUUeQ8HO2entCcb1vAjGxWhYrKSdqCaOObuSWq?=
 =?iso-8859-1?Q?6svDofhVcgcMvRu1OVY4eRJGgNcp7Ymf+jZojCdXSTXigxE0R9VN2rAmzj?=
 =?iso-8859-1?Q?vD0RJ0Gfgh/GgiDUfMX7gcE3ha4Hq530B4+nNVOn/VnM7Z72M77jGDbWqd?=
 =?iso-8859-1?Q?DyZe9PMnK4NXugaPf6NS+ir2/04onm9qyj2r56k/CgMItjP0cOpu7mKe9+?=
 =?iso-8859-1?Q?i7idSDzOf9afGw2vlCvbtwDYQPHC8CWwPQZ7WeSBPTXsNltOGpS6WIrH/8?=
 =?iso-8859-1?Q?2Sgg/7Lg0QBr25blfguNXl52c9aGFEzpxxOaY1l/YH9+BkJCRHi9Z9tP4B?=
 =?iso-8859-1?Q?zHLqdJBOxXKfux/NOty4/nAeeS1JjZ9sH6UvpVlEJg9cCVkPsKBZFpakXf?=
 =?iso-8859-1?Q?g44j4wkcleN1MYkGBMJbREU7kWIdrericCt8pOPuWwQu2ziDVz1RJwQPSu?=
 =?iso-8859-1?Q?O+hKTPvx0ri76ZU2VZwyB/r53hcrkgsMdxicl5Xw5e0zkUjIFPBOXjIPfW?=
 =?iso-8859-1?Q?cN5dfPyG2ie06XNDUf3PO4En87cDuDHHT9u8pObjw4eUaG5i5uZ0ByKKN2?=
 =?iso-8859-1?Q?Lxhe/rCepaIFcdckKKSmXfNHE2GzMzSSKexjsZIOUJY6PAmjy+3yGT9K4p?=
 =?iso-8859-1?Q?Q5OdLOQt4lUwQooVa/9zVffx8zohKhdbMRzFukq/vzbIAdC4vYqVTtcinr?=
 =?iso-8859-1?Q?kTBlMI4t7oSTNQPcDB61xq6I2uPepDeScfwur+SC6DY0s2Iq/pVvpFtgZa?=
 =?iso-8859-1?Q?ljb1Clx1O+N83ryRtXPuSVrGOpyuobkqaaBy6rLbgO5r06k6OAJRvAisrF?=
 =?iso-8859-1?Q?u0MquwPkpnzYoBiAMmS19H6lt0uhZONamzMnhoukPtjxub8j4eT4PInGkU?=
 =?iso-8859-1?Q?6dj9iWmYWw9/GLJ2juFXt5s9ksw09WQiG8ZN1kbl+6a2YZNc0YTzHzFUNJ?=
 =?iso-8859-1?Q?1B14Eqd6OTImHvwBrfc47uD+L19/S0jaAfnvRgdztXzNxnwoIcRwFlzHaF?=
 =?iso-8859-1?Q?Ce0QlWCD0/i5iHrTUTYpgB6gzvFYcGOoGRFFWPGIYi4m53Nk9rzt+zYRQS?=
 =?iso-8859-1?Q?kKz/zdKjA1TZG1F51GhWyaFuyjxkGuIWLQv3O5GXqtUmSAT35wjtyFfenh?=
 =?iso-8859-1?Q?pv0A3l8Q9/q4Hptmc+Gk1Qo5EoRYFJ8o217fFKUgK+Kze6MQQ5gzNSkJa1?=
 =?iso-8859-1?Q?5/mh+OY6UCxXP/i6cKWbZ1jJ44KMcHBHV8DqyGaf/+hbFZI7buyDOLygjx?=
 =?iso-8859-1?Q?inz0zfvsNmdLX9Q3ig8a1UrFFnecvGrIHSAwjDZUcYhTh1RvAuJwBnY2KH?=
 =?iso-8859-1?Q?aAd78tHauVOuYJWLo2Q4649wmjBEnmcRW3zpL8cbEEZNql4CaHYitGj+F9?=
 =?iso-8859-1?Q?XxClyC7/J+j1wnXgQsE6Sf2bmBG1vqYTieFN7lbvFzx2W2RAHUqg7RFCZ+?=
 =?iso-8859-1?Q?9H+rk8DTKPYiUnGzi4ro5c52POEoHYOOmGS7aCpCXU1LMlmsJiv1XyH2LS?=
 =?iso-8859-1?Q?cOkU7OxxyJEQEjFwF7f84gAVUL8aknhFRRNTwwO3MaEZ9mTdz94IIgb2KE?=
 =?iso-8859-1?Q?k683il9w27EYDh/VD89bQY7XhetdfjjW02bjX4eQRBpHrQjvZ6qDs9/Adk?=
 =?iso-8859-1?Q?EFblRVUJ7zLeUxws+6FSEkRAWPTVt185nljXlca/ZbxMsjlRf8yqbtSR4s?=
 =?iso-8859-1?Q?VmMRMrk1wA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892f3624-6419-4fb7-4403-08defc23d7e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 05:53:20.9088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2jgpTnBeseJPbDjP+3YkhrBeLmdQhj4c79l8u03BKXsQh8+7tRDrY/w3C8gEyJQNf7sR71FuP1XkJfIOCreGq3663NDKy/BiGFjUMCFzjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8880
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

get_dwords() and put_dwords() return -1 when ehci->as is NULL, but that=0A=
can no longer happen. The sysbus variants set it in instance_init=0A=
(ehci_sysbus_init()), the PCI variant sets it in realize=0A=
(usb_ehci_pci_realize()), and usb_ehci_pci_write_config() only switches=0A=
between the bus master address space and address_space_memory.=0A=
=0A=
Meanwhile the results of dma_memory_read() and dma_memory_write() are=0A=
ignored, so a failed guest memory access is silently treated as success.=0A=
=0A=
Drop the dead NULL test and check the MemTxResult of each access=0A=
instead, so that the existing -1 error path reports real DMA errors:=0A=
raise USBSTS_HSE, clear USBCMD_RUNSTOP and stop processing the=0A=
descriptor, as the NULL path used to do. All 11 get_dwords() callers=0A=
already check the return value.=0A=
=0A=
put_dwords() now returns void: none of its four callers (ehci_flush_qh(),=
=0A=
ehci_state_fetchitd() and twice in ehci_state_writeback()) looks at the=0A=
status.=0A=
=0A=
Suggested-by: Peter Maydell <peter.maydell@linaro.org>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 38 ++++++++++++++++----------------------=0A=
 1 file changed, 16 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 451a918e9f..ecf98c4e19 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -421,16 +421,14 @@ static inline int get_dwords(EHCIState *ehci, uint64_=
t addr,=0A=
 {=0A=
     int i;=0A=
 =0A=
-    if (!ehci->as) {=0A=
-        ehci_raise_irq(ehci, USBSTS_HSE);=0A=
-        ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
-        trace_usb_ehci_dma_error();=0A=
-        return -1;=0A=
-    }=0A=
-=0A=
     for (i =3D 0; i < num; i++, buf++, addr +=3D sizeof(*buf)) {=0A=
-        dma_memory_read(ehci->as, addr, buf, sizeof(*buf),=0A=
-                        MEMTXATTRS_UNSPECIFIED);=0A=
+        if (dma_memory_read(ehci->as, addr, buf, sizeof(*buf),=0A=
+                            MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {=0A=
+            ehci_raise_irq(ehci, USBSTS_HSE);=0A=
+            ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
+            trace_usb_ehci_dma_error();=0A=
+            return -1;=0A=
+        }=0A=
         *buf =3D le32_to_cpu(*buf);=0A=
     }=0A=
 =0A=
@@ -438,25 +436,21 @@ static inline int get_dwords(EHCIState *ehci, uint64_=
t addr,=0A=
 }=0A=
 =0A=
 /* Put an array of dwords in to main memory */=0A=
-static inline int put_dwords(EHCIState *ehci, uint64_t addr,=0A=
-                             uint32_t *buf, int num)=0A=
+static inline void put_dwords(EHCIState *ehci, uint64_t addr,=0A=
+                              uint32_t *buf, int num)=0A=
 {=0A=
     int i;=0A=
 =0A=
-    if (!ehci->as) {=0A=
-        ehci_raise_irq(ehci, USBSTS_HSE);=0A=
-        ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
-        trace_usb_ehci_dma_error();=0A=
-        return -1;=0A=
-    }=0A=
-=0A=
     for (i =3D 0; i < num; i++, buf++, addr +=3D sizeof(*buf)) {=0A=
         uint32_t tmp =3D cpu_to_le32(*buf);=0A=
-        dma_memory_write(ehci->as, addr, &tmp, sizeof(tmp),=0A=
-                         MEMTXATTRS_UNSPECIFIED);=0A=
+        if (dma_memory_write(ehci->as, addr, &tmp, sizeof(tmp),=0A=
+                             MEMTXATTRS_UNSPECIFIED) !=3D MEMTX_OK) {=0A=
+            ehci_raise_irq(ehci, USBSTS_HSE);=0A=
+            ehci->usbcmd &=3D ~USBCMD_RUNSTOP;=0A=
+            trace_usb_ehci_dma_error();=0A=
+            return;=0A=
+        }=0A=
     }=0A=
-=0A=
-    return num;=0A=
 }=0A=
 =0A=
 static int ehci_get_pid(EHCIqtd *qtd)=0A=
-- =0A=
2.53.0=0A=

