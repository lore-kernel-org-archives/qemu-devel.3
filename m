Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8059F433D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBrn-0007rV-1b; Wed, 15 Apr 2026 21:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrX-0007qR-MX; Wed, 15 Apr 2026 21:49:48 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrU-0007PV-IS; Wed, 15 Apr 2026 21:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6wdI/wkVuJXx6kok9oz6xOiazI9eXPPtMJ+agwUo9LXwRqjHrHYwdTJWoXxI2lhcW8rUVzCI4CFL3wI0mHmAxKxJ3ZcX+AuLzQ4WS85UgmIlGYOW9LJmI/7we9/qsubQkvnv7oWDfszPIk0dCF9tHKMVNhch+u1kp8f6P8OCQUZ5Q4UGcuD1UpJmX6rHs6E7vWYikbSn+sB79OcYhYrWNpqQLGE/diXy/FNILRVB2hSRO32Crl1K+c6LZ4JhHxR/89I5Z0Fdyg46domUoZpaVgc0ew0Y8+oReH7Qz0cQA/fddKoKMBM36O46sl0G5Ys8y1KqjIYYICRw6j2X5r4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+qkXLls/pt40Z1VqrqM0+XkmKAxAHjDWMBW47cohns=;
 b=oOu9ePvyFjgu1PV8QLqCxyuLfrHjTGSYuSgXsPgHYTykGrgO1U/SpV3bT9W2hnEbqMfTdPR4i2LMRyvsGpJKF//vTekjHyN/Liw5367qCh7FNskb3iLLp1FdamNYEziHRC6xhnQPJSd1UZh+8UqTdTvocxPSc2MiJd+krD35asW39If+HuaAj3hhIcXrQVCr5QdzQ3P9BphqQc1ufFRoXN6NPmAVsT3Y0zklWY8V07pxYIKAKQQ9ShHO8ARR69rgXeG4LWTaWuNlncbJDqKM5teEwUyb5MaNLjGOrJ0vUcvS3PCwkN+vGgWLcc+dnmgJzLKPWFp4dHO1BiFXriQHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+qkXLls/pt40Z1VqrqM0+XkmKAxAHjDWMBW47cohns=;
 b=BClpfyZRnQxXWrke9I+Y6xs+MioKWPn6Mxhpz00BmSfrUGAXUxmWezHNWYC6YfL2XMuRyyl+NOuncg2aWH1h8QZpnbPMIi06Cr4Sz//JHUsWUtGmfymwVEFYoSXXKSU3vFYJ/DoxSjh7esURhMhy+M/mnGaNQAGJ8HNWrCWlfywSBpdupR7gfRQJ0VO+yZYO6rPC3QRePZ1gJtsi37XHwsVoFm0Dy4SdiJBvU4539yuJu4LFvWGUZdD4Vuks94LYqXCYgvidRxwwEhZ44iRXbFR0Yy2zm6egG6HFA/GOIyh7W6zSrtG5QymxS/q4zdzMjbm/i1GVF6sdlG9h69JM5w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn structure
 and dead code
Thread-Topic: [PATCH v3 01/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Index: AQHczUNFhK5MCMsaPESXZcYoH3r+fA==
Date: Thu, 16 Apr 2026 01:49:32 +0000
Message-ID: <20260416014928.1279360-2-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: e860cd68-55fc-4e6d-8a99-08de9b5a67c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: OSgZZeJ2E4NF/kg8M0YFy46LB5a54f5R+pL+rMDy5D3z7DmxDR61a7JuQDHrAKueGCS3mMLcHTncT6fgl+xB5YIHrpRy+faKVbXsPZXXWmk//USPmUv208fMy+YDwe+jSAXuGFzx0BaQOx6BFcUn8AeExduIHRsb9bG0y4EnhB1JIYfzvH7t3yA8p75XQJwN/3ld3mOA7IGs6yD5Hg21jCsQkoEww3ok5TNrlQ1fGwmjctq5XI/oqEDgACd4Ht9wiCLid5xPkIzKQeStSuymn5QlFdMUjYaq4s76IrHtk+qO+5HVilqE4VQtpvRJ0+AfGPMEhYSr7PxSkK+aV81KvsXyKohzyjE9KT8mpOGv036DUPZCq6wxB+4wH0lgFBRSR6beg2bSJgwlGGTmlc0ssJMhSlbnG1QkRSKYXyclftowS8Iw9sGx5d+P3VTN/0ZjBfx/ToE8d+hheMP5wvblnnRu3lYwAX1Vy9FMMyDaU3Kq6daWwohuxZ+FXNoXd0kXaPf039tmu+lkv0n7LLldWr0TvUJ3GmA+ME7zwXJ7SPBRyulOnJEhjd1IdrQ2D5xh3Mdk5RlWQ6JePqI7aBNpWqJvHxBSOI1aDO1kXRrZGrCEdbSLSRI7LSTRdfCyelW4M9oI5jWwYw5g/4EnsGDuvK6kR/G96W/CztVKi4y7kp+HilgcB88dHmtmiCvM3y1o2gVYStfC+Vt4emiVAOq0xAslb546yDzNDrW3YDWCJNDBYyA+waItdXuBWWKV26RFK59cO+vjHJoNUeQ1BhzGDih3lGShDVRk8+GNCvCQfhdL6N0wJ2IS2VDuuGHcuHpO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UEiYYRBFxM20Ht91PB+WgjGKFV4cpY1HJY+6t2PSk62PlfaucLGi1QbEuN?=
 =?iso-8859-1?Q?0hOMakYFrVeYVo7PzR0nILl24Dp6FInK6tmhFvJ3kC3O9UOtO1L5Q8whL/?=
 =?iso-8859-1?Q?hP8ROtcDxxrBeRDVOK/dtQCx1la3eN3e2exXtjcdAYdE7V+AFuJgOTbj16?=
 =?iso-8859-1?Q?9OkbST/dbzS8U/6Fgire9amjoR3kfTtTwkyPvkJt0mb9eOmACHBayVF2A1?=
 =?iso-8859-1?Q?xD8I+AuMixPGo/dro6SBmlNgFg4d+V872fyXQmhzQE1YsSxU5u/1uz6PfL?=
 =?iso-8859-1?Q?tapprKlGDq3pDeNpfk63DwyecFIgBUOYrCirLLjjh39vauJpwjEKqkW/wA?=
 =?iso-8859-1?Q?wX80PadH1daXTioCt41RzI2+sRcmQPr3vGJLgQ246cBYbzmsI7tU0I+H/s?=
 =?iso-8859-1?Q?syuWP6oMo3SPyLbdO3XhRk/6Y09tDFe/LzeS9rn7jbgY0uI5lNBsEOaovo?=
 =?iso-8859-1?Q?3BaXRx7U4FP3ovNlvgpRJpSu/czxniwvWi7h29MdX7ATucikyOm8f1VSY/?=
 =?iso-8859-1?Q?dx2sTvlGVAfXYrOPsLRS0+SIy4Hesv3KLvaMNN9VeWO6YJSWMOyvG4A1Pb?=
 =?iso-8859-1?Q?uJA56vE5x9QGYZcUGE2SxHcLc9kAAZ0k+quFV2dfjOZefTQVkpszuNNjt4?=
 =?iso-8859-1?Q?dBeJhNBtaKuIlAjeAKdZw3TqDSlf8NviupaCAL//aznbWpUjyO/waDLX83?=
 =?iso-8859-1?Q?R+tXvXKSmT5FHvCflOV59/6hWUAtdKnIKxQdajQDSs7izbQcaBc+auMaQp?=
 =?iso-8859-1?Q?3Z0eUK9FKbHR+djnvsCNBdKPPEiZqPmtHHbOm71WQ3rnFcSNrE9bIISfU/?=
 =?iso-8859-1?Q?X9sQv7kjqQpyE3kRC6HJMJYQHRS6MRqRuv5yEKz8WsVhfqoWz0tFJ5LN4U?=
 =?iso-8859-1?Q?ANIIjoan3LfzUt3kaWduPYwWOkx3a/cvGhTBMSipsXed/oIaR/cdKBtT+7?=
 =?iso-8859-1?Q?t/xaOKfGlqcCAQfisAmjYRUJ/4Lkh/w1BMkX/oK7Oix6FPND4VSBIdkpS5?=
 =?iso-8859-1?Q?uJlzMvEbigLS4nrt/R+wVtnShFL9Uphk8No1dkand88Eyc6PrYoqX8beCF?=
 =?iso-8859-1?Q?i/HZkrA5fVt4ExXskZ7gW+X+YOsrkTv1gu5pif90BKB4Webhz9vaUAiuSL?=
 =?iso-8859-1?Q?zmWBk1WTnBwVquBkhPuzRXkqf5elUa7mHGTMgmTEpKUzLpkc7/va9jlGBN?=
 =?iso-8859-1?Q?MTBm8D9NcysgDzspCShA21FgdESswnNCmRUjlEWmKu6sGzldhB61oGd+7E?=
 =?iso-8859-1?Q?d+1H9zLVwjP5Uwv0kPd86lXXTwqTtNvKcem1RHiqg+Tcjz9sPYAWz9Vi/J?=
 =?iso-8859-1?Q?1jbCaz+rxi1KXHsDlGnM7ycKNBIyrvNhw1Zuw6yyd7UzO2hmejASuhRz+1?=
 =?iso-8859-1?Q?0qPeAWKtPoY+vC1D229AiBDo9TCKioZZ86dy8ATs/+Pl+k5wn6BX5HZ08H?=
 =?iso-8859-1?Q?mkJR4Ib7RSe85PojoKwEXCpeRVApkhgSIL+Z+7MQ9vdc+TUkTZmu2kIlfD?=
 =?iso-8859-1?Q?Qx3kWnAaBqxS85VDewpi1AC+eccy0IBNKWJn6MNTzf6Y8qqwGTpeFk8FSK?=
 =?iso-8859-1?Q?UE5j+Rr7mG0eQUKQl5eleCgcMy4brADJk7+ValDRDe7Ov/L48nDHkIEc2b?=
 =?iso-8859-1?Q?P2auLwCTVPsDTmFJYR85rpLvP5m+WzdfC8XHFNw1G5aLPgF6KQSFXjnxZb?=
 =?iso-8859-1?Q?3hFZG6BI+dT9IjXZnx6loZDaPGSwuczP5mI7MUpMGogc1PWxMsgW5TsUov?=
 =?iso-8859-1?Q?UxkN6qfOymQ6/9cUz2LLsUeDA4nQWiC7WHnv4bOOH3+E/lzSmgMsLAccz9?=
 =?iso-8859-1?Q?EbTMBSVchA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rkTR/6KmfcJhZWkVD+QYQSwpf1V8HmHYTaUpg+HvsLxyB7Ee1c/FOJzv6hDDNZw0o40Fjyew56E5ncTEe2wbSY65lC7mCI+6t+qM+SCiKtmp/AN3jylZtwEiDfd/sfondHqe+Rh1NF8SMsvY3bxqkKOxuFURRpBenH9eDRuiQxdC9zddet7/5XTMpUtSnJ8byMNzQnbialGGGEQ8wNzFQC4eIhEmQD3rM4T9AFEKSm9zB3A+ESfLBbFN9XGa/40CQe3RdEMpj4Bx83Xx8LkqvsvBEXuC9zF/jxpVVTt2bUa+tleo3emPPKD4ztB4GgLwSSC/qKNW3C9wUGyDz5EMug==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e860cd68-55fc-4e6d-8a99-08de9b5a67c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:32.3080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFIEFf8bcb7siebkWPpmFAo3WUcQxGnMKWQi6EktfpiQRF2pg4P+i940FJSKFM4KmiPf7Z3kvrgOFK5OB6XFcrR34wRS7JrAisRmTtpUrS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

The EHCIfstn structure, defined according to EHCI spec section 3.7,=0A=
is currently unused in the EHCI implementation. Remove it to reduce=0A=
unused code and improve maintainability.=0A=
=0A=
Additionally, drop a block of disabled (#if 0) code in=0A=
ehci_state_advqueue() that was never implemented. This code path=0A=
is incomplete and has no functional impact.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  7 -------=0A=
 hw/usb/hcd-ehci.c | 11 -----------=0A=
 2 files changed, 18 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 0ae8c06331..3aec0e047c 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -202,13 +202,6 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
 } EHCIqh;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.7=0A=
- */=0A=
-typedef struct EHCIfstn {=0A=
-    uint32_t next;                    /* Standard next link pointer */=0A=
-    uint32_t backptr;                 /* Standard next link pointer */=0A=
-} EHCIfstn;=0A=
-=0A=
 enum async_state {=0A=
     EHCI_ASYNC_NONE =3D 0,=0A=
     EHCI_ASYNC_INITIALIZED,=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 57f930b099..5ea8461f70 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1756,17 +1756,6 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int=
 async)=0A=
 /* Section 4.10.2 - paragraph 3 */=0A=
 static int ehci_state_advqueue(EHCIQueue *q)=0A=
 {=0A=
-#if 0=0A=
-    /* TO-DO: 4.10.2 - paragraph 2=0A=
-     * if I-bit is set to 1 and QH is not active=0A=
-     * go to horizontal QH=0A=
-     */=0A=
-    if (I-bit set) {=0A=
-        ehci_set_state(ehci, async, EST_HORIZONTALQH);=0A=
-        goto out;=0A=
-    }=0A=
-#endif=0A=
-=0A=
     /*=0A=
      * want data and alt-next qTD is valid=0A=
      */=0A=
-- =0A=
2.43.0=0A=

