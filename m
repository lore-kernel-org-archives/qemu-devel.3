Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1F9D172CE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHm-0005zP-Pc; Mon, 02 Feb 2026 01:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHj-0005yJ-5B; Mon, 02 Feb 2026 01:19:43 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHh-0003N7-Ca; Mon, 02 Feb 2026 01:19:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnGqXhPwm+7NndNRnazz1fkbUN26eoB9zxlKu+qNB+2QSBZsiabCow60HZQvH9nRPQ/mfMTVhQzMQ5wcJ5qUKrVKe8O18Xf8G/N4+lsKAzg/KgUbmQp6GejlyCZoaQ7dVzOKE4IzmLE22bBkZz2bqfm0/4h8XeuJyi1toCoskwAneX/U4uhNLv8z5C5WvnJjQWGu/SttBZFtNFDOcjMAQqrPja0mW3J2NYLxtUGHki3iC0vCAW667FUIQma2FCe/55gjosw4bCGggcN0O+4R0aO3F5C9qzTvy1pFI3ckyUDkoSgA7f3Fnaa5IPtNbVKUocp+3UFJVEG0NsZLS2o5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r49wD5LIpGlMQYLgTBkfVbQYTqo5Hmdf1TYl43s3wvY=;
 b=mTy+QrDmKnBNNBrNjpRpoZ2T/IkjMY2OVeMJ6nfHg1Thio3yOzWe0r21wTzLTu6ZuIzriHgUxmANYwdTMPwFBO1HfvyRz13WdsaZik93Ay0v6AnLl4S5BbK8aF5s3cljB5TfQ6qJk+kiuskVEq6mPUXreI4DJsHsHhdjhIf1Kz5WcsKL40FWzlgBmWAhAyMPMA1mk96XH4Mz0IH+UEudtfFQ2EPCoA5srthKZaFuWz1VzC4QT4h6ZO3Hjbx+h40xVyWWRqy/DPynNzczuknk8TuaE41rVSH8frO8ubBORr+8OJnUfDW9HAxVGa0EfOA4q64hetrT3MIR5aXUsRFEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r49wD5LIpGlMQYLgTBkfVbQYTqo5Hmdf1TYl43s3wvY=;
 b=eP4848l/wgbC51C/T4G/M05UjzwZqVfiIa0HLEE0dQY4jr8EUmC1ByZYfV4/k3XsX3WPOI1ldez/jvfzDbZLeU7S4Cr9XK3qLXDLTAEOVmpBTNNWZiKJAXESp/bnMgOUZd2wFkXFBGOVaRjVw/VgUIpKmFB93O0FuW4xjMtAsQgj3GKf/IDZo8tGYb3RirJNdAyJkPB3TRXerTrFJfR03c1bizmmePzrw+KrK+pKMyx1z+N002jxfSwDp2WFbnU4o/p8nlbCm7BLd7yBMGh06QOX3Vd5mIaYQFV4JBggxxLhGt34IFuZqm289gFeGDPAk7GyySm6QhVQE09qDYPZxQ==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:29 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 6/8] tests/functional/aarch64/test_aspeed_ast2700: Update
 test ASPEED SDK v11.00 for A1
Thread-Topic: [PATCH v1 6/8] tests/functional/aarch64/test_aspeed_ast2700:
 Update test ASPEED SDK v11.00 for A1
Thread-Index: AQHclAviOCN67dJyx0C5GC8Rat0+0A==
Date: Mon, 2 Feb 2026 06:19:28 +0000
Message-ID: <SE3PR06MB8199D277AD25416693F81884FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: 003f6d7f-bb4b-4e9e-c3f2-08de622305ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?A7wmaEAscXoH0hzxqcYpfNHNKW/soAO67RkY2CihPHB6vmQ/DhbNGgrSXlQE?=
 =?us-ascii?Q?ihdbnvK6l5NS7qdEQwR998fExqikiXRSzYmZCMHjd7aXdKslHkIRo33hGyV6?=
 =?us-ascii?Q?+wldWQJ3y0alEOSanUOZDRVaIjcTLeBYnXISKHbS6U1YbJQQ9YLp18Y6GLLM?=
 =?us-ascii?Q?IlgqyWAKjyD8bs40IDOdmWy92sc/aqsUZ4yQygnNUJMMErSF9ddCJfqMFHSC?=
 =?us-ascii?Q?sN5u/Fcr9n0pm8sJ/wyQ3cbb1eaW+wPN09+99fHgffbz3iyrvmm1lVJS7cmP?=
 =?us-ascii?Q?hD0jo9UmLhLODGqnFSLTyS9WIRaJtdXbXPCXzHeG8iuMG1aHs/TgM38vwKxF?=
 =?us-ascii?Q?FOvYRKt4cPKDQNO2FfqY1av484PKzCOOvV/DaXec3PDkEkeizIl3+T7p+8ZY?=
 =?us-ascii?Q?PsUpRZVtNULMZmax186jhV7JMX5CkTyvTW8zWKBqADeC9MwLwtPvAEnyAHhU?=
 =?us-ascii?Q?0THE2SAWMj4C5q8TdBs98OcDP8JrT0P2q2AvcB8pMT1StjcTHx4jR3Wqc1E5?=
 =?us-ascii?Q?/n0Ts5Kua7aguvBBgLv5TLr35uIRTlSTWbqmhXCyOyKn3ktAJg/21Jq3/ch+?=
 =?us-ascii?Q?tDavumn0EnA+tuaW4SGg5gggN65WBRgJv9zvydOLmD+2enX/8HSqbGqaOgQP?=
 =?us-ascii?Q?LABztFqVd/RtraN6wZRJo4/hIwHOHRfUBPi88aEP6HuzBfP1+1bnm4Ve15a2?=
 =?us-ascii?Q?EF2PfjNH5mqMjQyf/FAMRh7IA9sFwMTE2fMjd6SxSr30MY4h0uWVxfpCcnmx?=
 =?us-ascii?Q?MtHDGBUpArNbAfcRnN5RMgUsRu7PiODQKurHC/0E5izpmdq5jb1o/s7Gz68E?=
 =?us-ascii?Q?mi3MYfNFXfjF4MqIiS7K5OoSmJeNqhJsC/qMAEsfJ+l+n2gsDifHCteIV+0w?=
 =?us-ascii?Q?sOg/5pibRfcMFzj3ZEc5mJFi9fhPGyFr5iLoB6vfD01ZAvqtpc2DeTYcNOhK?=
 =?us-ascii?Q?4ydahCF8PNFdc40DjXIaj7l3J3+dTKK6eSLFL8xo2mlPmZlNmNKoS1Uj3r/i?=
 =?us-ascii?Q?tP4pT2AzvNSYsruCKOLbRq+RSdFtuIVoeC/MlEyFjsqIJXTFSsTEyIb62+pY?=
 =?us-ascii?Q?VtSBhDtRSpDDrFOBYhmh7BWjjYIhAxHvRlBnULEGHTLEFl5rmvy6HtFhmuki?=
 =?us-ascii?Q?+iuRbmBW+X1Zszt13TV5Th7NkrB2tzOMrrUsmBtIXJNYq1+YHNNIYCObeclB?=
 =?us-ascii?Q?Z/7crsGFqy/5ghm7qTTJ1cKKd3ObwgGkCad8AvKhL7FY623qHMQd2dEv+87/?=
 =?us-ascii?Q?lOUnWyNUeYL4//4AG9bkNp7tnk7TkFhmVn4o8SrJPAjsKcj0QVj18z5jhpZP?=
 =?us-ascii?Q?tnwz48qotFrPdUHxJeJobH+hBOveP/0xwlPKiECvSjvMOJcShv0hcsKMmq8i?=
 =?us-ascii?Q?2XnwXTze7UxyuwGZiHGg8/Xp1yb7T1QJIAP25s3zoLhLFAqtuDej6Ety0BNo?=
 =?us-ascii?Q?8zSOX58MFNLNanM6oA2Mh+oEgiRqQtLDC91OMaK/tyhPCCu9NS2gO3hX+D4F?=
 =?us-ascii?Q?07S8a2Gw7FZFmQUxJINQKBIV/zMhrtZbTxsNfiqpCcNZ6o8IaUEN7ecp/Cv1?=
 =?us-ascii?Q?X/fUnzFifrZkgtZL/YQ9kwsS5jpUgU12m4cnjv01xV6o623Izb0tPSWr4NKl?=
 =?us-ascii?Q?PQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(7142099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zc1AgUaHIOyKFzPREGTa0wOs0fcu9Bm7Si6LYOkyusmG/F7prgKFNp/UwhlN?=
 =?us-ascii?Q?IRei/NhGjP7a9+nlAWNixoBWuPQB/v+Q92ijnvFeH58kttw1ESHuSksAk3d/?=
 =?us-ascii?Q?E2IpM6icdEw9ZNMVzBwyAjwty1vlXWf5yhnwy2zZkD1p5V30+6rkc0ZqDY/+?=
 =?us-ascii?Q?QASNMC2sskIbkKD5pvAqvzsJ9D+6c9cGg0SIko8YdgIuSvy5W9d9prmh1VPc?=
 =?us-ascii?Q?fmPnHh6s+PtX3pCAiNTfzJ8yQFc3Sxk03b3PAZBBXC9lYYXa7phXjSr6tnwi?=
 =?us-ascii?Q?Cvm1O5Pn3V6vHonO0+lFrBHoIxZ5Wx7gAMsP9rjzku0jc6YObqd/hnjXQINP?=
 =?us-ascii?Q?TPyJPLkrZ4nYPfAaHGOXFQgaTzpVYh/YjpnbNbY98Ddiy66EF79woOJZU4xX?=
 =?us-ascii?Q?rjPaD6UILCfifm9Ea0znrLJoe1DF8Fm5bqb2KT6iccJpDbU5Gc08wB3Cw0pk?=
 =?us-ascii?Q?jegZN1oXflmDyoIZX1ZughRAdxhdY/SDNc1GrKb3+1i+bmrkq5ShKzmDt1uX?=
 =?us-ascii?Q?Q62F6SbV8YyIfks3Wi06BWExDgCqn/VmfY7OaQAATC6FRJ/imsLmU/uURmH1?=
 =?us-ascii?Q?CJXgcRBRMH3GEXJkHY1IVeomrKEAc+W3jQdlPcjcQjnxiswmwSeoK4/VWpxC?=
 =?us-ascii?Q?D5eDniABr37EvDuH3wDTW6l8olLFQEwA2fS0kqjezbmEYiQvHcjXySEHOW6Z?=
 =?us-ascii?Q?WHVbKEaLHR9iSzEk2G2F09tzXizp8hCvf2zrpRs6Q+qFDVBlffANmf3j+U4G?=
 =?us-ascii?Q?1ZbD0gqHcIcYQ62vrWJewzdKpQ2tzgnw7tTIB/S9fbdEI/tR6CqZlcWLDF6K?=
 =?us-ascii?Q?EDElolvig+sweyL0eU1PqW434/dQXNlFAPuDiU5vHk8MB312DvDCmeOfjt3O?=
 =?us-ascii?Q?1HJ+lV7yjtnCcCcPY3pkoH5ONJR79flGDtc+h3UHHEzgMfIWwDDvaflHwmr9?=
 =?us-ascii?Q?m6+PqXv7iZElSZ8Z7mTA48jdIxnNlWy3wBO7Osu5AQlSABYSsa8gbutPm57y?=
 =?us-ascii?Q?/hMc89WHof6WYV1xtaQvA8eKI6F/GA/PkiF5J+ke76G4V2L7GXcahwStCbtF?=
 =?us-ascii?Q?VnJ5PQ00B7VlBlJA+GUXyIfcKTkWmuPPidTWQGqtHQQ15wJ8xq3545GqfKH7?=
 =?us-ascii?Q?VJACvRW15e6C/4HM4F4hfTKWGLffLnhGTBKPIhpm+ohochyYQhc4eJU+42rN?=
 =?us-ascii?Q?Xctl3UNll1T2yeNrXJ8y3ZmA/1ElPl+GD2ixWPsJZD0d60lksKgwUIv38/tv?=
 =?us-ascii?Q?J3JPJ+/sz7zo4rTxfv7K5ywomLNiBcLGF9SAb36tRY8o7jVdsM1Vo46310JF?=
 =?us-ascii?Q?dXMi1c+VaSjZ1KXyOjGJTPLaAI09eRgspM9qcj2uLVyYvQ8gTQ2cbOZ9b+q7?=
 =?us-ascii?Q?izQsgawtXw5Gnx1SVxORlZju0frI+sT32ESBxt1TfjTAKm13EdlM6Zez5twE?=
 =?us-ascii?Q?opgQPoAxQpTlfc0zyGj802dpKfq1pRjeiV6HRbqTM/OFApfLrpRcEZ1LsQYG?=
 =?us-ascii?Q?RxvORsMFhRicO5ddP+spFpETCjL6zVaPsekuifVkmPq1rVaBUti9EMQK0NxQ?=
 =?us-ascii?Q?XKUFIcqdML0eCg7J1bO6tAVmfNPZoMWVcpZxK4P6VYHkGDwXr7Gkyeo5a0Ng?=
 =?us-ascii?Q?Y/Hivg+5/IlYlrEcEfh6m4SUR1252Dw1db+q3C1oP7OkQHHxmUznNIcyU0su?=
 =?us-ascii?Q?48MHK4kqzIG1iJwDzxbkk9vFcSc4rFW576CE6eGuscdyHQ8is/JSfL+YzbMJ?=
 =?us-ascii?Q?vn3mphJd/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003f6d7f-bb4b-4e9e-c3f2-08de622305ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:28.3976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bTJnA/u5rgQYZOj9zdp5B2tpsmJ3JBVXJouJeJPIbvH5DAklF+E7o1yCLqRp4LxvPuv9mU9iDl6Ubyu9AhBxVE3NVg77XZCEstFecQvfVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5142
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700.py | 60 +++++++++----------=0A=
 1 file changed, 29 insertions(+), 31 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index 1f1b5749f4..828ea1ca53 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -26,15 +26,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
         self.vm.launch()=0A=
 =0A=
     def verify_vbootrom_firmware_flow(self):=0A=
-        wait_for_console_pattern(self, 'Found valid FIT image')=0A=
-        wait_for_console_pattern(self, '[uboot] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
-        wait_for_console_pattern(self, '[fdt] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
-        wait_for_console_pattern(self, '[tee] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
-        wait_for_console_pattern(self, '[atf] loading')=0A=
-        wait_for_console_pattern(self, 'done')=0A=
+        wait_for_console_pattern(self, 'Found valid caliptra flash image')=
=0A=
+        wait_for_console_pattern(self, 'Check flash image checksum')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read abb header')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Read soc manifest')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load atf image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load optee image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load uboot image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load ssp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
+        wait_for_console_pattern(self, 'Load tsp image')=0A=
+        wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
     def enable_ast2700_pcie2(self):=0A=
@@ -63,9 +71,9 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    ASSET_SDK_V908_AST2700A1 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
09.08/ast2700-default-obmc.tar.gz',=0A=
-            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e=
2cd')=0A=
+    ASSET_SDK_V1100_AST2700A1 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
+            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -93,19 +101,10 @@ def do_ast2700_pcie_test(self):=0A=
 =0A=
     def start_ast2700_test(self, name):=0A=
         num_cpu =3D 4=0A=
-        uboot_size =3D os.path.getsize(self.scratch_file(name,=0A=
-                                                       'u-boot-nodtb.bin')=
)=0A=
-        uboot_dtb_load_addr =3D hex(0x400000000 + uboot_size)=0A=
-=0A=
         load_images_list =3D [=0A=
             {=0A=
                 'addr': '0x400000000',=0A=
-                'file': self.scratch_file(name,=0A=
-                                          'u-boot-nodtb.bin')=0A=
-            },=0A=
-            {=0A=
-                'addr': str(uboot_dtb_load_addr),=0A=
-                'file': self.scratch_file(name, 'u-boot.dtb')=0A=
+                'file': self.scratch_file(name, 'u-boot.bin')=0A=
             },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
@@ -113,8 +112,7 @@ def start_ast2700_test(self, name):=0A=
             },=0A=
             {=0A=
                 'addr': '0x430080000',=0A=
-                'file': self.scratch_file(name, 'optee',=0A=
-                                          'tee-raw.bin')=0A=
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')=0A=
             }=0A=
         ]=0A=
 =0A=
@@ -137,26 +135,26 @@ def start_ast2700_test_vbootrom(self, name):=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_v09_08(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test('ast2700-default')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.start_ast2700_test('ast2700-a1')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
 =0A=
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):=0A=
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700A1)=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
-        self.start_ast2700_test_vbootrom('ast2700-default')=0A=
+        self.start_ast2700_test_vbootrom('ast2700-a1')=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=

