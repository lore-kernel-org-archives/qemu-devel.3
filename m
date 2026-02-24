Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63F4EFB805
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6S-0001kf-2f; Tue, 24 Feb 2026 00:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6D-0001fC-Gx; Tue, 24 Feb 2026 00:36:45 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6B-0001I9-Ui; Tue, 24 Feb 2026 00:36:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc/opP/iRGutgX++mdAyIaLiLB3QAKtxyo+KIkbJRq7foqlA1h3CBwxgyJvMXi9GfmPT0HPXSc9kpq6/YqN4QNBMQe3VHXxBHWFpv5Ot0X+mgiWIlWiSbDZSE9plVIGEd23Gz3kXBjw63FsjE2yjnbt6A9warKKohd4gg/hQQxcV3HTXYyRpvFumZ+2J9XDzU+8TKCjLGXVaua4Uu/DHEDSpjGRd5/IyZJKkZGDXmOxAo1z4zXEJKT9VNWlenmCXk6Wz3xOIdXgYTLGGYNrYSGtPBXrtXENb9oWBV5xS8nQlnB70apaJsdkovrRunMY1A4P3a2aL7UbPlSPX4xhHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMxAsAYfx53AKhxN5W20oAsMBn07pjlGkco4igIC93I=;
 b=Z0IwpDOioE3R3pFVMhRJIrg/QCt0m1Rz+cRhz5+ZOce/lGprKkUfI8TcbWQXySAlMpuFqiq1DfcZsxzCn/Vf+dQuH95hXRbaYcwMGPEPne/Ki+xsXmB/4SJ9ckoXIo26K9Q84poyhKERbcz36dLvmGEfVHXAlKB85wSQ9xCZB9sFdRKEY4yy8Fy0rG9JTIxuLSBWlXJdqDiL8VqAKmMbiPCnELT5fPgc6qmcx2ym+CTEN2j44HnNO8MR+jofkYOFWgWh6oVj8sOx/NtvbLYgz+PFY6krgfVOJjB31EOigkLAbWdwE6bHooWdTSIi8m23AJnP+m0O2HGIWmKNdanWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMxAsAYfx53AKhxN5W20oAsMBn07pjlGkco4igIC93I=;
 b=d6aF234p6OH2CFuNiA7xaAulnnbycznzA8OOw5fkUH8VpPqLUQgfEynq2X1OQHerxIC390PPV0BtPcdV3E3RD1UsUsjNijDGVjrEouVG6rcMORRKhMowG4lKe6XeFGOgKkda9dcMGaQJJF+F1dLtvt68Qz9ZwXc6f57t5s7BrReWjevp8MrF67Pf56DlJxMVXsIwD3fUDjTccoun0UnfyUW1Ayg+AI439aHrRRJQ6GGevkwjySkvUfQAWylL1mlREBVfdC63/isk0fmjeL0MATqG/3iRZRrwDWVsCOXBY/qMHft8to8mbzD/mkxMGHx2pfPpi04GS4woaapM1aheLw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Titus Rwantare <titusr@google.com>
Subject: [PATCH v6 11/22] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Topic: [PATCH v6 11/22] hw/i3c/dw-i3c: Use 32 bits on MMIO writes
Thread-Index: AQHcpU+HcmPWRGH+akqjwQK27kgq2w==
Date: Tue, 24 Feb 2026 05:36:30 +0000
Message-ID: <20260224053613.589102-12-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 34c95a6a-9b47-42a4-1699-08de7366aad4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wcV56DnIR+M6yikXjRf/ZbI+E5AovARes5z+TYy18kzO1zgvkC62/7qB2A?=
 =?iso-8859-1?Q?WA0kXXJ79hwFk+DJYbhe3Swy3isoJCAW7O6fYGqKRZ99N1E8bkiAXRvpXY?=
 =?iso-8859-1?Q?9SviV6GMKgAYaNsselZoC+YxbmwFrshXVzHVZmX8o5UuNrdvWrcwU9suQm?=
 =?iso-8859-1?Q?bBONpRwho0nF+DD2mSpEjvUx+hKG2XD5at+BiDulWJJHFXgCHXAL7L1Ney?=
 =?iso-8859-1?Q?5joyZ/bPO0XP58WoWv7dgFJ9Kdg4aHbmeu4IybBi7YFUlrsNM4murB9zwe?=
 =?iso-8859-1?Q?JnODMFI6+cYbopEg/OZ/rDQQt9tNRTjMDGumetTtNR9QEKPWMuMg8u0GAq?=
 =?iso-8859-1?Q?q5e6dKQbeTQvbOCtO/Pcz8EFcXSZMhvEqTn0nFS3RnmngfSYhUrNd1FTjH?=
 =?iso-8859-1?Q?Malw8VSw0k5RZXZEA4xL19Ft3QkHaM1jG4ovzdhvGBT4gJVop8ImHhgNEa?=
 =?iso-8859-1?Q?mQ2i1pnr2RPtgfINokS/QSOQDioYP88JlPAu63gCouHK8aOTtppu3xNDpT?=
 =?iso-8859-1?Q?LBBRdadYolovMWFQiXArtHx1qMwGKgT87xYgClLusyjkikFyjY/F4nKiJU?=
 =?iso-8859-1?Q?tjtdBKEv37JSYh2mGHlWpkA6tsKktDhqL0GrzW/A2eJdCkXpOqdvltUDjZ?=
 =?iso-8859-1?Q?GwXQ5mh14QgR2BnqRGl0fFyLLvm7vR0EIej5D1K7uYjdUlHc8E9Zv16Cv3?=
 =?iso-8859-1?Q?p3Hzs0wAIFholaMijFC3F3VBDt8gfVtRFXxtJ6zEt1uTXYDnkQTCfohdga?=
 =?iso-8859-1?Q?HP/nnsl6OYgGOOGU19BrOGqFd4TZJEC9qzzRLwbvCc9tlduHHzTPp3BuqV?=
 =?iso-8859-1?Q?7oejb4U7M68/n7RSEPRguhyZl5uzxQl3uSnp3Fhwt3FZ0DQ1Cl1/wkPHAo?=
 =?iso-8859-1?Q?pG478CbZwLj+kQz3X6IJO6EkVeuqCwjkKaLBio7CFXHobdltswxSPvi36M?=
 =?iso-8859-1?Q?QKmrVu098yp6zr4GhR2R5o4QlrmbfmjcZkJBYC3vICl5lOBBWNku9XCnBx?=
 =?iso-8859-1?Q?VSmboz+HXC56q00fzxIbW0t+9QyRdnTKp8my35Z9qqPlLUQmrj6RowRJ0w?=
 =?iso-8859-1?Q?eWMj3xHA2soELA8qfHI+ETEf1B4sNXnCu/q2egU5uFDDbviAiVDFKD5SVW?=
 =?iso-8859-1?Q?de4+KFVqrTb62sIYy1PH/t+gi1eu7epnkcBRa6tu67rxCdVniE+97uAakI?=
 =?iso-8859-1?Q?zw9UFpGj6Jb5lXekLl7T+v3tfgqlfzHO0HgapLf95r7AsQIvndAmW0ZiiY?=
 =?iso-8859-1?Q?Zyn1cNVSzREt5s6RU59rpRJAw8pEug5GBXK9syfMituP8pKBQtjE4Z+F5e?=
 =?iso-8859-1?Q?yIsyRTRHWDQ8WsKdOao7ws7n+JMj2Lme6VROABg7gsF5wDrZZm9KyO6BQI?=
 =?iso-8859-1?Q?NZrmK0P5sPCDFoz2KZFimevyI+p1c1WE23XsWlJkSbi31+4kJMMcAr+kP9?=
 =?iso-8859-1?Q?Ky2Y2mWl5YoB02qieAIZ985+aLnT0POVClG4yPMeSjbECe6Wg7Huqyew+i?=
 =?iso-8859-1?Q?YaXtn/cTeB2ihKMDbxJEfpTTvPM5mcLehohQCwwPBA07wmNZNMRrgDFESC?=
 =?iso-8859-1?Q?M0g65B7t50Qvznfw+6MtlfnYyv2x7wnxSpFFdTcYO2JIgsODEjThZCFii7?=
 =?iso-8859-1?Q?z4JG/r6scpmXwIRULLq5zmp7tW4hoowl3N5crB6BpQIdWPY97pFmg6qZXs?=
 =?iso-8859-1?Q?dbQLH3LT/3fbqULxfTDOnqEhJK4gtpl7uIw7Zp4m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Uz1r07KYwZG8bKXOUXfuXUbM8Fl4cXGLuyJje6hO4DXj+lqoss7X0ItWdA?=
 =?iso-8859-1?Q?NzhtA6QAz6sNqQRyh7UIOgGFot+HiGLYP05AhaTAfdvRLqt3XKriPmVDa/?=
 =?iso-8859-1?Q?U0pQAQYb/GV3wAuuQUgbaiiVaqizog7NYjujicGnSQxLMxNloK2pXGf2Wd?=
 =?iso-8859-1?Q?hw+2W3fve0EZTe9zOSsG+DdcFZgeLOfVOppbosyX070cx89YQbcXxbTnse?=
 =?iso-8859-1?Q?U+RlxxXg9Z0pQKqTb/1kAPvhxw5Ofk0/B69gy02AMKvvCWwJMzGXLlW/U/?=
 =?iso-8859-1?Q?O43quMK2uKYYZCcTi2JPDqWK1EsjZNIgXqtdi8Ee0QH45rQhPwyZ+5yUdJ?=
 =?iso-8859-1?Q?Ty+BADFbB53NP7YQeODmTRcJmtYPXT1TD6UA1yNFEfSKOiV1iRUIlWf1gK?=
 =?iso-8859-1?Q?O71BTNI/rxDFlg6puhR4L35pBmXXeYeXYmnvzVXs/yvU7HD8W8s420UBwj?=
 =?iso-8859-1?Q?9mNjPTQg3YupIYCRTbzJl5NbbAidozUBn8jaIj8MS872kP6RY/FaO6dBN+?=
 =?iso-8859-1?Q?5dmPwbrA+1NAQ8lBT+pZvxdoqw4MW1E0GRS6B6/Zc7gSUehzPxpKkokotT?=
 =?iso-8859-1?Q?mO4wNiQQ4AHK4RGVPOAf28d+sXc3CkD6N+FHKkvppcDFd7SVtb4L03a+Wc?=
 =?iso-8859-1?Q?KrmWGO6T6WVCdWjnYRHplHlG/T7/eOLgz2X1SmqwaErg7b0suA7CdLoy1H?=
 =?iso-8859-1?Q?Mtv+TFjFTIWsifE1mUBxIT0FoYrU8brItzL8QO2sD6N77N3Bavu/Cy+kV2?=
 =?iso-8859-1?Q?wJ+QRKNVWQs8rtkjtBEgWyJl116D0qJmN1Jp68l7r+GJaExC1BeNahYnNm?=
 =?iso-8859-1?Q?f3zteC9PIE0tWgmqQ5X7FBQXmHoInoEM0z4b4kBUEWmynbboVANpCVoTRV?=
 =?iso-8859-1?Q?+v2KUj1bC/vCgi9WtVjPWEETW2WWTenBlrilK58U1Qo5RGVyjyItp8xUjq?=
 =?iso-8859-1?Q?Fw/coClTyFOsoB519Qc4hzdGrB7JQbBNovOny+k915Izi5fy9qacx7JsrT?=
 =?iso-8859-1?Q?1tzzQursCakoos8iTqFgOK3KOxrVKtjxsYDxkRXUc+gICw8+pGhgbBqNJO?=
 =?iso-8859-1?Q?uIGQtrDRL+AkH05gTLSwDvr1cj/S7c7bNo5Pn9aWr7PXXqQugTAy7iFoo7?=
 =?iso-8859-1?Q?yHw44u8s+huMgcvhZ5vZJUHGMZVQf+oeIn5RKKasNWdu2sX5JePWMHUtPw?=
 =?iso-8859-1?Q?9hZ40VMvAqX4DGEl8GZjXiMD5wqzMz5Wtf6Jsh0QTmyF+oPrgmLVev8Gge?=
 =?iso-8859-1?Q?wKp8Hdyls77+KDVGcbOcndt2uXlCx7gQQE+FmWQgBSsbVJgYAxCdbM2VOJ?=
 =?iso-8859-1?Q?lZqGl1+3Z3snGK6oIzUXHYFO8IyisVzumLABzCi8q/HF9BEu1AuOwCsfQu?=
 =?iso-8859-1?Q?wyUEsM6R8FiZO2nt9wk28IQib8h2dDwMrZZp+YxHGzWAvJGZTTblkmnMtO?=
 =?iso-8859-1?Q?iTizqF+UsLbjgqRE10CpXAbm6IIwgQBi6kALoReRgjTiz4vE9fAxq1jexn?=
 =?iso-8859-1?Q?GlHt+nwAeLlkwX7OVRPCtX2f8p4CibMULySMJMOIRK9WYT5f/GchnT4G7b?=
 =?iso-8859-1?Q?sKmcd/EjMdtALNsYEGyCxXQtoude9R/uPch9kTKtZC0vXiG9DW9a8MDZlA?=
 =?iso-8859-1?Q?KuAJEJYB46rkE8I1FukOQYEyxVKgVMCGFQYfPDkE062jw5qhx4NlsN71+v?=
 =?iso-8859-1?Q?HP5huENC3xvzJHD2jD/KX2WPPiJKrN7smF3RPAgq8Ur4ZmSaTaG9MyUpNO?=
 =?iso-8859-1?Q?ziZE6FW1yg5Zq0IDAcGoHT2GBrpR0Va9+wsCOkyKQuoMJWs1t5OUrTeSVR?=
 =?iso-8859-1?Q?7r0CV2mWFw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c95a6a-9b47-42a4-1699-08de7366aad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:30.3462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qy4d4T84HO/VhwAW0gLPqvQ9mVjqDbHvienFvLsvP3TTarzH8zdKbGzVyQJYtFvRCL+z72YCb9B4WDW85fX1y4IiYo69N8drCGDA1DAvvz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

The registers are only 32 bits wide, so we should cast the 64-bit value=0A=
passed in to only be 32 bits wide.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index eeaf1125e4..7ca99fb87e 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -363,10 +363,11 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
     uint32_t addr =3D offset >> 2;=0A=
+    uint32_t val32 =3D (uint32_t)value;=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
-    value &=3D ~dw_i3c_ro[addr];=0A=
+    val32 &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
@@ -392,7 +393,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
     default:=0A=
-        s->regs[addr] =3D value;=0A=
+        s->regs[addr] =3D val32;=0A=
         break;=0A=
     }=0A=
 }=0A=
-- =0A=
2.43.0=0A=

