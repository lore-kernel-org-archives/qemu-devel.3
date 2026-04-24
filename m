Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A4FB44C6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXc-00050S-EG; Fri, 24 Apr 2026 04:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXZ-0004u3-0c; Fri, 24 Apr 2026 04:05:33 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXW-0001Eb-3R; Fri, 24 Apr 2026 04:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPolPRyKWd2XjIhc83ajGYbW41uF1uJ4t31apS9JQlC9AeiCOf3m8D7cylU0kQW42VCs2vvRLXRcpDTZHrQYv91vmLNgAPG6/AjMxnKTZvAQWtBF6x3/Q+DdoZfNcf9ThKRfTtypLfNIY9L0CzMeBkjKRRj10S8VBPteeIu+plFf/WXuV5DV1xmfUEK1AYlipL4RCUEzrsYJJp5uOZpQEa+CiKMC3594aBn/ChHRUzsGZ0OWkcBZXYpuCEEFyLShsb0SYkmaySQuQ+FBZafFTBqRo30KpWphcgJ93xdntwj5TuH2n8uZaUiko5b58Z3/pMeeee7fTsJNCvMp4GMX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njr4wCoeju2QssBCsergfxNnAQJ7Wb4og1kRDdF9wIg=;
 b=B2uz3EhAMWwUabFASd7IBt32Vcj+taOMyfhk9/xDaPjOeUhXBE+XXeYAlO0g5ybm+pqVAj59tcdrTAWM7lFu2v0dS0kzg2ZazZQB0wdQA0306Z7SDhv+l9ocq96RQ75NV5EedRvQuTCtUXQUaSk0RgrZgrT2EtjCd1UnI2ukrTbnyK3AkXSSqaG1mFlkcVDQjpE4NJ9A77VxOioduhDB8ghkWe119fBnqpwXOyQWPYMLojmoyKn1lidX4Ow9UXeOEpuW8Gf9VAu07muQjYPcaxKenx+JlbMF6cnTtCDdF/7Z/c5n6tNpf0UBa6CHpe5oK9WOmX23aEYJLNNi12OVkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njr4wCoeju2QssBCsergfxNnAQJ7Wb4og1kRDdF9wIg=;
 b=g+n0cwOwaDpYP+OtyTBeYc0LrSw10WkF5RPPmBq53tfniM+o4WCbbY9b7Lomua9U0yPfGVDjNmLJLtpxzMEn20tfleaWRKr7psvPLSXtAeLw1z0g2Nw0jKKlJH0klLWRkmYlb0DPcWYv8CDxjb1+62eBWP5mZFDoMi0mbi53qe5C9vZMlxT6ZWH3aeJ02Hgxl3SrderTvwhDqFYk0qCB6HMKBfLbSt6LtAwNKzYvT88RU/MmqRly9ycO/13e7MpNC61n6n+QpNMGUbjdonrYMLMVF/YR6QKb3/k8r0ysTtNhotjs9wD9cmeyxS6Ao3TH/P7vb6lSGcm+eWQDBFY9vg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:15 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 04/18] hw/usb/hcd-ehci.c: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v5 04/18] hw/usb/hcd-ehci.c: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHc08EUlA9tchRfQE6UwrHrmEmDUA==
Date: Fri, 24 Apr 2026 08:05:14 +0000
Message-ID: <20260424080508.53992-5-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5790:EE_
x-ms-office365-filtering-correlation-id: 8b1b70f5-fa8c-4f15-3f04-08dea1d8377e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|18096099003|56012099003;
x-microsoft-antispam-message-info: cif/Ny4VQogLmqVY56OPZ2B5wNowz0oRrgXg3SvvDS58Wpziqo7zywbScFAg+H1nCyAC/fSrE/v81jKbkGTC3507B3jBPMRNj34ej1WbuHutpoL+flSVjtYxQzdFtgw6TtkF/UyVwbYmWq/sslP6c5d33LR7esfv+kA0+enma2ZnKAEsSoKgn5cbFAIPiKc8vNjyKst/Od4WNRv7+11QJ0toTS9X3S0oU86cOpBplR7hpaJ1TNX/7l1fKYgeOu0Gt6W9S5SXbK0Am3SfAQRVXJTBGGK3UMloZB69lpDgaiR8TdYEtotVc+r6iHuC0zlktyIUq4x4WGIzDNPdrY6+AO77JOoanMEs65h0PyPpzKlAjJpZaCR96c6R0kBLjeMNZrIc0Dk2lBipwQwKKonBEaytt1VE8ZExG+OOqawC66BZxzUjlDEiEvgKBf7bxFuHiwiCAThty0dbuxwZUoJuZqS4zeSfQ48o3DzTNM680KvTpC+6P/9etiAJeqt11fAOWkT9/R3xxDnfuuo0nBkT/JED2YH7hcJg7sxdGd1PaNKj2E2OmLWa3rorPrX3DNnmJV2HhguImvDD0g5QuwzP6+vLUJvM8SJ7afoP1mqHmBiEmGII/A2ZDyY5QJCLzzxAJiqKUdMb4LGUnzzNmG4NCw1k0kOZJ7hlaoYJh3pHSs5O1VeF6Lf5eZKHhXIbctBC6Pifnt5jHYpmzQUJaq7xLVbCqqCRiopgcO6KdYMAD+De6P1yz5GYBq4c2eLXoAvBjvqcdb0UD/LN+RLt0fvuY9LG5/z/+4McOdX7Z+myFcRCmiGo6XfTeFbT4gGClIkp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(18096099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z1ABad4YZ7Y8PsZI2oioxmbgF2/B+7QNYmzcASKLs/Yq8Nl+oZphqlVUPg?=
 =?iso-8859-1?Q?RqZxzRj+YATMXvekhbD+H2IKnM8ZgJfTjlD6L2s6Alb4rQ4K+vq15jfriQ?=
 =?iso-8859-1?Q?N8xtMSmGrhy51VAVTyyA3HC83P5oFZq21qV/5iR11NCLpDqxVdr22QnP/Y?=
 =?iso-8859-1?Q?U0nwPwJOLeAoOnqvQSaQn6zKAxlW/JYxLNX0MSALfpTG1ABICCd5sA09io?=
 =?iso-8859-1?Q?/eyxEP/4v6x5iS2Wi5PeUVKPM2ZxR0h0e8DEpa3xyid/sdHUeglJ/98srp?=
 =?iso-8859-1?Q?aPaznG6GLn6gSBnH9c2f0AmH8Sd5YmFSkBXz7RDqQ+HVhhlPrEuP3HaHnb?=
 =?iso-8859-1?Q?W9HVhXPtfjsDCyGXz9VFtrHMgFNs4/3e+3sW6ajxGsxkW0qO832ksVKqyd?=
 =?iso-8859-1?Q?gjQ8l9YiuBNQIrK0Yc0U+HF/5UsiDc1Yrtzqb/TpB+/0DXPTlE20NSk8fq?=
 =?iso-8859-1?Q?RDcFX6zQl6iJAWtb+FxpfqhjynVhQirqu5yjeuC0OoSzs3l6P+BMz7ktuy?=
 =?iso-8859-1?Q?yIaT+YD3EhyeHeC+ptxMGsjO1ez2WK6xpRaDObpI2mjCde8rVkvokUKrkF?=
 =?iso-8859-1?Q?3ic2Qxt7ooVu7dsu6tb3UtDCD/r/T36CtQTP/X8RAc7WEVxsXpJzFlOhXS?=
 =?iso-8859-1?Q?m7o/GqrFv86ApCg/4MLW5Fgt8OSUFLkCi4wt6D+vPRNt8luIvzYP2FZKvu?=
 =?iso-8859-1?Q?aYBGNMfgAwGoIDZLniEuWtGYphwpZs7rszHB5i3CD6l5NdSjJmQA6SlnNx?=
 =?iso-8859-1?Q?ZU4IgUxizyvILWbPAbxUJiMdIXpdsi1Vx8tZsVtpy92iR/q2IHzelZWNyq?=
 =?iso-8859-1?Q?rb0LsVNQzvQdUxHEeOTl0Yt2arJvNA+lILf7iY9lvvIM9QruawnsiZY15s?=
 =?iso-8859-1?Q?YUzeHil6Kfp58ogBhgyarJgaEwxCt/AJZ2Zbxqfi36Kf1Mq5fyyh7/+VzR?=
 =?iso-8859-1?Q?gXoDMihrRS5HqD8y98STFzPItZHXtYgRGlhYQZfGUQqhaKn4XAG0Xtvjoz?=
 =?iso-8859-1?Q?/6XY8BRtu7GaxYkpTQf64gnR5P0uM8TU1HsFWWFPkLjhM/jVcFi9Ra573E?=
 =?iso-8859-1?Q?lxIFnym4+KgjGw2ei6u9UVknvs8Bxb4JYZMpvtZpAhxGZCAKLrJcYmV15w?=
 =?iso-8859-1?Q?7AYYIpz8hEUGhLNuNms02r2OpgWdtHC6vfp/JxFW/EZj0BwsywsyiIGFy8?=
 =?iso-8859-1?Q?l/T+eDmLbMYssIRTvWHwttoPXsMIkzRz3Bx7/1BErhmRjyL6JJd/BAfGx4?=
 =?iso-8859-1?Q?EFyIchvsNYdctRQpYuZw+ur7Re5aLDcXPwhZBXFcabeUArl04QbOHYm5ya?=
 =?iso-8859-1?Q?I3zYJh2SV+d7rtNEEiIbzp1WSauY6g9cyRh+ZJDYJH4XUPknza7B1RCu68?=
 =?iso-8859-1?Q?YjiwYyb9KCL88C5BhBRe5zZAnzDmgkDBKdJAj3KMquVD3ifwMIZKwhaFUY?=
 =?iso-8859-1?Q?E/xVq/MsiANpdaeKrCHyR8vBbJEiGuiwEoEQHlPcJSBmdslNqU82HGRc5e?=
 =?iso-8859-1?Q?yjYlbYy9AOfgEyKyInH9/nqKjoidExdjQP6E2dN8hg43WDtUfO/JYXlJAj?=
 =?iso-8859-1?Q?Rev0szshJBK8mRcOLgDWiIn3tY1yqKTD8L+0SzfbngCsBY8GeVmMuS6p+D?=
 =?iso-8859-1?Q?pdKPsSn0tP7rDlP0MK5IiN+HG3NVtJa8Foj/mzGKX2GHRFjgr1NAZ929jT?=
 =?iso-8859-1?Q?8EdHB1eSOSmj16eR7XCDYbIkRx4vlf/jtQAG98sgkih6Foh/ZK59UGpIog?=
 =?iso-8859-1?Q?iDIJQwvk86YgeWzGu++wRkpRXwI6YrdYQ8bvwcqDReNkq06O6nAnqtg7PK?=
 =?iso-8859-1?Q?Hl5ARTSEXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FEM0IBUuQc/wOaPJW5WY5r8n6Vs/J3kFh7JkDYHD7KkcOF2fO7uplHDkC6W7Os4ztKMb3YSKC/Wad+JMC3auVDHcuMd3pXTGlxcT3qfrPd94L5JCXve+Y9vts/mB4GMt1+WnhTEtIn3FkS+MR99RIdYmtCop4c6EgGrfUZHhIqPyrHRh2RBvi/PjAchwdGbVs101rJzoVcZp1mD3I0Ag3B5OUgEGclH5v9J+evwY+wBXiWTfVZt9uZeyg4Buf1gRgmbCPd+e67DpesXX7Ia3ox+bY2AIByuN99BTD9vf9OWtJHFqX2+VmsBKi8nFSDRRPCHN0vfeUmCyqN/XTj/7sA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1b70f5-fa8c-4f15-3f04-08dea1d8377e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:14.8655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FK9OdcYA7TElTeIvkeko3r7VTkk108MWFgdCnuhuWynZeqpCwR7vcn6a1B4efTD+5GsM0YjAje8dNxr/JllofslPwwY6gFpPiMQ9HY1Xo/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 129 +++++++++++++++++++++++++---------------------=0A=
 1 file changed, 71 insertions(+), 58 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 23167bf96f..7e0b767eb9 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -41,21 +41,23 @@=0A=
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)=0A=
 #define UFRAME_TIMER_NS  (FRAME_TIMER_NS / 8)=0A=
 =0A=
-#define NB_MAXINTRATE    8        // Max rate at which controller issues i=
nts=0A=
-#define BUFF_SIZE        5*4096   // Max bytes to transfer per transaction=
=0A=
-#define MAX_QH           100      // Max allowable queue heads in a chain=
=0A=
+#define NB_MAXINTRATE    8      /* Max rate at which controller issues int=
s */=0A=
+#define BUFF_SIZE        (5 * 4096) /* Max bytes to transfer per transacti=
on */=0A=
+#define MAX_QH           100      /* Max allowable queue heads in a chain =
*/=0A=
 #define MIN_UFR_PER_TICK 24       /* Min frames to process when catching u=
p */=0A=
 #define PERIODIC_ACTIVE  512      /* Micro-frames */=0A=
 =0A=
-/*  Internal periodic / asynchronous schedule state machine states=0A=
+/*=0A=
+ * Internal periodic / asynchronous schedule state machine states=0A=
  */=0A=
 typedef enum {=0A=
     EST_INACTIVE =3D 1000,=0A=
     EST_ACTIVE,=0A=
     EST_EXECUTING,=0A=
     EST_SLEEPING,=0A=
-    /*  The following states are internal to the state machine function=0A=
-    */=0A=
+    /*=0A=
+     * The following states are internal to the state machine function=0A=
+     */=0A=
     EST_WAITLISTHEAD,=0A=
     EST_FETCHENTRY,=0A=
     EST_FETCHQH,=0A=
@@ -71,13 +73,13 @@ typedef enum {=0A=
 /* macros for accessing fields within next link pointer entry */=0A=
 #define NLPTR_GET(x)             ((x) & 0xffffffe0)=0A=
 #define NLPTR_TYPE_GET(x)        (((x) >> 1) & 3)=0A=
-#define NLPTR_TBIT(x)            ((x) & 1)  // 1=3Dinvalid, 0=3Dvalid=0A=
+#define NLPTR_TBIT(x)            ((x) & 1)  /* 1=3Dinvalid, 0=3Dvalid */=
=0A=
 =0A=
 /* link pointer types */=0A=
-#define NLPTR_TYPE_ITD           0     // isoc xfer descriptor=0A=
-#define NLPTR_TYPE_QH            1     // queue head=0A=
-#define NLPTR_TYPE_STITD         2     // split xaction, isoc xfer descrip=
tor=0A=
-#define NLPTR_TYPE_FSTN          3     // frame span traversal node=0A=
+#define NLPTR_TYPE_ITD           0     /* isoc xfer descriptor */=0A=
+#define NLPTR_TYPE_QH            1     /* queue head */=0A=
+#define NLPTR_TYPE_STITD         2     /* split xaction, isoc xfer descrip=
tor */=0A=
+#define NLPTR_TYPE_FSTN          3     /* frame span traversal node */=0A=
 =0A=
 #define SET_LAST_RUN_CLOCK(s) \=0A=
     (s)->last_run_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=0A=
@@ -88,10 +90,10 @@ typedef enum {=0A=
 =0A=
 #define set_field(data, newval, field) do { \=0A=
     uint32_t val =3D *data; \=0A=
-    val &=3D ~ field##_MASK; \=0A=
+    val &=3D ~field##_MASK; \=0A=
     val |=3D ((newval) << field##_SH) & field##_MASK; \=0A=
     *data =3D val; \=0A=
-    } while(0)=0A=
+    } while (0)=0A=
 =0A=
 static const char *ehci_state_names[] =3D {=0A=
     [EST_INACTIVE]     =3D "INACTIVE",=0A=
@@ -472,8 +474,10 @@ static bool ehci_verify_pid(EHCIQueue *q, EHCIqtd *qtd=
)=0A=
     }=0A=
 }=0A=
 =0A=
-/* Finish executing and writeback a packet outside of the regular=0A=
-   fetchqh -> fetchqtd -> execute -> writeback cycle */=0A=
+/*=0A=
+ * Finish executing and writeback a packet outside of the regular=0A=
+ * fetchqh -> fetchqtd -> execute -> writeback cycle=0A=
+ */=0A=
 static void ehci_writeback_async_complete_packet(EHCIPacket *p)=0A=
 {=0A=
     EHCIQueue *q =3D p->queue;=0A=
@@ -733,7 +737,7 @@ static void ehci_detach(USBPort *port)=0A=
     ehci_queues_rip_device(s, port->dev, 0);=0A=
     ehci_queues_rip_device(s, port->dev, 1);=0A=
 =0A=
-    *portsc &=3D ~(PORTSC_CONNECT|PORTSC_PED|PORTSC_SUSPEND);=0A=
+    *portsc &=3D ~(PORTSC_CONNECT | PORTSC_PED | PORTSC_SUSPEND);=0A=
     *portsc |=3D PORTSC_CSC;=0A=
 =0A=
     ehci_raise_irq(s, USBSTS_PCD);=0A=
@@ -858,7 +862,7 @@ void ehci_reset(void *opaque)=0A=
      * Do the detach before touching portsc, so that it correctly gets sen=
d to=0A=
      * us or to our companion based on PORTSC_POWNER before the reset.=0A=
      */=0A=
-    for(i =3D 0; i < EHCI_PORTS; i++) {=0A=
+    for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         devs[i] =3D s->ports[i].dev;=0A=
         if (devs[i] && devs[i]->attached) {=0A=
             usb_detach(&s->ports[i]);=0A=
@@ -877,7 +881,7 @@ void ehci_reset(void *opaque)=0A=
     s->astate =3D EST_INACTIVE;=0A=
     s->pstate =3D EST_INACTIVE;=0A=
 =0A=
-    for(i =3D 0; i < EHCI_PORTS; i++) {=0A=
+    for (i =3D 0; i < EHCI_PORTS; i++) {=0A=
         if (s->companion_ports[i]) {=0A=
             s->portsc[i] =3D PORTSC_POWNER | PORTSC_PPOWER;=0A=
         } else {=0A=
@@ -942,8 +946,9 @@ static void handle_port_owner_write(EHCIState *s, int p=
ort, uint32_t owner)=0A=
     uint32_t *portsc =3D &s->portsc[port];=0A=
     uint32_t orig;=0A=
 =0A=
-    if (s->companion_ports[port] =3D=3D NULL)=0A=
+    if (s->companion_ports[port] =3D=3D NULL) {=0A=
         return;=0A=
+    }=0A=
 =0A=
     owner =3D owner & PORTSC_POWNER;=0A=
     orig  =3D *portsc & PORTSC_POWNER;=0A=
@@ -988,7 +993,7 @@ static void ehci_port_write(void *ptr, hwaddr addr,=0A=
         trace_usb_ehci_port_reset(port, 1);=0A=
     }=0A=
 =0A=
-    if (!(val & PORTSC_PRESET) &&(*portsc & PORTSC_PRESET)) {=0A=
+    if (!(val & PORTSC_PRESET) && (*portsc & PORTSC_PRESET)) {=0A=
         trace_usb_ehci_port_reset(port, 0);=0A=
         if (dev && dev->attached) {=0A=
             usb_port_reset(&s->ports[port]);=0A=
@@ -1065,8 +1070,10 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
         break;=0A=
 =0A=
     case USBSTS:=0A=
-        val &=3D USBSTS_RO_MASK;              // bits 6 through 31 are RO=
=0A=
-        ehci_clear_usbsts(s, val);          // bits 0 through 5 are R/WC=
=0A=
+        /* bits 6 through 31 are RO */=0A=
+        val &=3D USBSTS_RO_MASK;=0A=
+        /* bits 0 through 5 are R/WC */=0A=
+        ehci_clear_usbsts(s, val);=0A=
         val =3D s->usbsts;=0A=
         ehci_update_irq(s);=0A=
         break;=0A=
@@ -1131,8 +1138,7 @@ static void ehci_flush_qh(EHCIQueue *q)=0A=
     put_dwords(q->ehci, addr + 3 * sizeof(uint32_t), qh + 3, dwords - 3);=
=0A=
 }=0A=
 =0A=
-// 4.10.2=0A=
-=0A=
+/* 4.10.2 */=0A=
 static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 {=0A=
     EHCIPacket *p =3D QTAILQ_FIRST(&q->packets);=0A=
@@ -1145,8 +1151,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
     assert(p !=3D NULL);=0A=
     assert(p->qtdaddr =3D=3D q->qtdaddr);=0A=
 =0A=
-    // remember values in fields to preserve in qh after overlay=0A=
-=0A=
+    /*  remember values in fields to preserve in qh after overlay */=0A=
     dtoggle =3D q->qh.token & QTD_TOKEN_DTOGGLE;=0A=
     ping    =3D q->qh.token & QTD_TOKEN_PING;=0A=
 =0A=
@@ -1170,7 +1175,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
-        // preserve QH DT bit=0A=
+        /* preserve QH DT bit */=0A=
         q->qh.token &=3D ~QTD_TOKEN_DTOGGLE;=0A=
         q->qh.token |=3D dtoggle;=0A=
     }=0A=
@@ -1397,9 +1402,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
     return 1;=0A=
 }=0A=
 =0A=
-/*  4.7.2=0A=
- */=0A=
-=0A=
+/* 4.7.2 */=0A=
 static int ehci_process_itd(EHCIState *ehci,=0A=
                             EHCIitd *itd,=0A=
                             uint32_t addr)=0A=
@@ -1411,13 +1414,13 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
 =0A=
     ehci->periodic_sched_active =3D PERIODIC_ACTIVE;=0A=
 =0A=
-    dir =3D(itd->bufptr[1] & ITD_BUFPTR_DIRECTION);=0A=
+    dir =3D (itd->bufptr[1] & ITD_BUFPTR_DIRECTION);=0A=
     devaddr =3D get_field(itd->bufptr[0], ITD_BUFPTR_DEVADDR);=0A=
     endp =3D get_field(itd->bufptr[0], ITD_BUFPTR_EP);=0A=
     max =3D get_field(itd->bufptr[1], ITD_BUFPTR_MAXPKT);=0A=
     mult =3D get_field(itd->bufptr[2], ITD_BUFPTR_MULT);=0A=
 =0A=
-    for(i =3D 0; i < 8; i++) {=0A=
+    for (i =3D 0; i < 8; i++) {=0A=
         if (itd->transact[i] & ITD_XACT_ACTIVE) {=0A=
             pg   =3D get_field(itd->transact[i], ITD_XACT_PGSEL);=0A=
             off  =3D itd->transact[i] & ITD_XACT_OFFSET_MASK;=0A=
@@ -1513,8 +1516,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
 }=0A=
 =0A=
 =0A=
-/*  This state is the entry point for asynchronous schedule=0A=
- *  processing.  Entry here constitutes a EHCI start event state (4.8.5)=
=0A=
+/*=0A=
+ * This state is the entry point for asynchronous schedule=0A=
+ * processing.  Entry here constitutes a EHCI start event state (4.8.5)=0A=
  */=0A=
 static int ehci_state_waitlisthead(EHCIState *ehci,  int async)=0A=
 {=0A=
@@ -1531,7 +1535,7 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     ehci_queues_rip_unused(ehci, async);=0A=
 =0A=
     /*  Find the head of the list (4.9.1.1) */=0A=
-    for(i =3D 0; i < MAX_QH; i++) {=0A=
+    for (i =3D 0; i < MAX_QH; i++) {=0A=
         if (get_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &qh,=0A=
                        sizeof(EHCIqh) >> 2) < 0) {=0A=
             return 0;=0A=
@@ -1564,8 +1568,9 @@ out:=0A=
 }=0A=
 =0A=
 =0A=
-/*  This state is the entry point for periodic schedule processing as=0A=
- *  well as being a continuation state for async processing.=0A=
+/*=0A=
+ * This state is the entry point for periodic schedule processing as=0A=
+ * well as being a continuation state for async processing.=0A=
  */=0A=
 static int ehci_state_fetchentry(EHCIState *ehci, int async)=0A=
 {=0A=
@@ -1674,7 +1679,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
 =0A=
 #if EHCI_DEBUG=0A=
     if (q->qhaddr !=3D q->qh.next) {=0A=
-    DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\n",=
=0A=
+        DPRINTF("FETCHQH:  QH 0x%08x (h %x halt %x active %x) next 0x%08x\=
n",=0A=
                q->qhaddr,=0A=
                q->qh.epchar & QH_EPCHAR_H,=0A=
                q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1756,7 +1761,8 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
 /* Section 4.10.2 - paragraph 3 */=0A=
 static int ehci_state_advqueue(EHCIQueue *q)=0A=
 {=0A=
-    /* TO-DO: 4.10.2 - paragraph 2=0A=
+    /*=0A=
+     * TO-DO: 4.10.2 - paragraph 2=0A=
      * if I-bit is set to 1 and QH is not active=0A=
      * go to horizontal QH=0A=
      */=0A=
@@ -1929,8 +1935,10 @@ static int ehci_state_execute(EHCIQueue *q)=0A=
         return -1;=0A=
     }=0A=
 =0A=
-    // TODO verify enough time remains in the uframe as in 4.4.1.1=0A=
-    // TODO write back ptr to async list when done or out of time=0A=
+    /*=0A=
+     * TODO verify enough time remains in the uframe as in 4.4.1.1=0A=
+     * TODO write back ptr to async list when done or out of time=0A=
+     */=0A=
 =0A=
     /* 4.10.3, bottom of page 82, go horizontal on transaction counter =3D=
=3D 0 */=0A=
     if (!q->async && q->transact_ctr =3D=3D 0) {=0A=
@@ -2041,7 +2049,7 @@ static void ehci_advance_state(EHCIState *ehci, int a=
sync)=0A=
     int again;=0A=
 =0A=
     do {=0A=
-        switch(ehci_get_state(ehci, async)) {=0A=
+        switch (ehci_get_state(ehci, async)) {=0A=
         case EST_WAITLISTHEAD:=0A=
             again =3D ehci_state_waitlisthead(ehci, async);=0A=
             break;=0A=
@@ -2120,21 +2128,20 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)=0A=
             ehci_reset(ehci);=0A=
             again =3D 0;=0A=
         }=0A=
-    }=0A=
-    while (again);=0A=
+    } while (again);=0A=
 }=0A=
 =0A=
 static void ehci_advance_async_state(EHCIState *ehci)=0A=
 {=0A=
     const int async =3D 1;=0A=
 =0A=
-    switch(ehci_get_state(ehci, async)) {=0A=
+    switch (ehci_get_state(ehci, async)) {=0A=
     case EST_INACTIVE:=0A=
         if (!ehci_async_enabled(ehci)) {=0A=
             break;=0A=
         }=0A=
         ehci_set_state(ehci, async, EST_ACTIVE);=0A=
-        // No break, fall through to ACTIVE=0A=
+        /* No break, fall through to ACTIVE */=0A=
 =0A=
     case EST_ACTIVE:=0A=
         if (!ehci_async_enabled(ehci)) {=0A=
@@ -2158,7 +2165,8 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
         ehci_set_state(ehci, async, EST_WAITLISTHEAD);=0A=
         ehci_advance_state(ehci, async);=0A=
 =0A=
-        /* If the doorbell is set, the guest wants to make a change to the=
=0A=
+        /*=0A=
+         * If the doorbell is set, the guest wants to make a change to the=
=0A=
          * schedule. The host controller needs to release cached data.=0A=
          * (section 4.8.2)=0A=
          */=0A=
@@ -2185,13 +2193,13 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
 =0A=
-    // 4.6=0A=
+    /* 4.6 */=0A=
 =0A=
-    switch(ehci_get_state(ehci, async)) {=0A=
+    switch (ehci_get_state(ehci, async)) {=0A=
     case EST_INACTIVE:=0A=
         if (!(ehci->frindex & 7) && ehci_periodic_enabled(ehci)) {=0A=
             ehci_set_state(ehci, async, EST_ACTIVE);=0A=
-            // No break, fall through to ACTIVE=0A=
+            /* No break, fall through to ACTIVE */=0A=
         } else=0A=
             break;=0A=
 =0A=
@@ -2215,7 +2223,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
         DPRINTF("PERIODIC state adv fr=3D%d.  [%08X] -> %08X\n",=0A=
                 ehci->frindex / 8, list, entry);=0A=
-        ehci_set_fetch_addr(ehci, async,entry);=0A=
+        ehci_set_fetch_addr(ehci, async, entry);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
@@ -2240,7 +2248,8 @@ static void ehci_update_frindex(EHCIState *ehci, int =
uframes)=0A=
         ehci_raise_irq(ehci, USBSTS_FLR);=0A=
     }=0A=
 =0A=
-    /* How many times will frindex roll over 0x4000 with this frame count?=
=0A=
+    /*=0A=
+     * How many times will frindex roll over 0x4000 with this frame count?=
=0A=
      * usbsts_frindex is decremented by 0x4000 on rollover until it reache=
s 0=0A=
      */=0A=
     int rollovers =3D (ehci->frindex + uframes) / 0x4000;=0A=
@@ -2320,8 +2329,9 @@ static void ehci_work_bh(void *opaque)=0A=
         ehci->async_stepdown++;=0A=
     }=0A=
 =0A=
-    /*  Async is not inside loop since it executes everything it can once=
=0A=
-     *  called=0A=
+    /*=0A=
+     * Async is not inside loop since it executes everything it can once=
=0A=
+     * called=0A=
      */=0A=
     if (ehci_async_enabled(ehci) || ehci->astate !=3D EST_INACTIVE) {=0A=
         need_timer++;=0A=
@@ -2339,15 +2349,18 @@ static void ehci_work_bh(void *opaque)=0A=
     }=0A=
 =0A=
     if (need_timer) {=0A=
-        /* If we've raised int, we speed up the timer, so that we quickly=
=0A=
-         * notice any new packets queued up in response */=0A=
+        /*=0A=
+         * If we've raised int, we speed up the timer, so that we quickly=
=0A=
+         * notice any new packets queued up in response=0A=
+         */=0A=
         if (ehci->int_req_by_async && (ehci->usbsts & USBSTS_INT)) {=0A=
             expire_time =3D t_now +=0A=
                 NANOSECONDS_PER_SECOND / (FRAME_TIMER_FREQ * 4);=0A=
             ehci->int_req_by_async =3D false;=0A=
         } else {=0A=
-            expire_time =3D t_now + (NANOSECONDS_PER_SECOND=0A=
-                               * (ehci->async_stepdown+1) / FRAME_TIMER_FR=
EQ);=0A=
+            expire_time =3D t_now=0A=
+                + (NANOSECONDS_PER_SECOND * (ehci->async_stepdown + 1) /=
=0A=
+                   FRAME_TIMER_FREQ);=0A=
         }=0A=
         timer_mod(ehci->frame_timer, expire_time);=0A=
     }=0A=
-- =0A=
2.43.0=0A=

