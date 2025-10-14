Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394EECCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lCO-0000EA-Lb; Tue, 14 Oct 2025 16:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v8lCM-0000Di-Vu
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:00:43 -0400
Received: from mail-norwayeastazolkn19013082.outbound.protection.outlook.com
 ([52.103.51.82] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohd.akram@outlook.com>)
 id 1v8lCH-0004hT-Ou
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXJnXbmXf2VvSLoynh8GcnjGtfGXD6tSWe5bSm1jymqQxgIfXTH4uzT38sWH/srZh9rViJ9R2mNsWh3Zpr9CA968Rzw6MfMYW886JPPXDHuzyEPKsLOt3sZ7ps3Mszhtd60cNdJNNsZgVFzFyYCgEemuq6sOUaAlntWQpgbhM0Y3GgiUpSS/6dmhQLDBbQ7z+zAEMHbtBXjeXH6OZVqwtlHEtQ0PCbTYWVUxygpBmwWHvTqzywegEGJKJTcJPU1nUW7A2l3ynQvM00hR4TEVw2MtmHoCXGWip4o+yQfXbNLVr+e0dyF4ig2jXZZqQL6BYQOzPl+E+447wex9kikeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6OgwAYwqbRsVMQf5JMU7Q+D77OixzL79nenxAUlHvI=;
 b=Ni38JzANhjdJTpSVovTA7+rNXc1K4IdoXWwUFxb/RzYxbrcc4xWe4dljRk0nQWOE2eydN1m0bZ9YigDxmb5WbaKgg4He/vQDm38HnVtYI1MVEyWiUidlQccF4Apq1ru/m42NO9fHypD1hKqTWMTFUtsNvakRCVfKwvyaOOxKoAlq0E9Ew6Zqu/WxEoUoP75GAitqfQq0FFU9wapw31CXoPUN29lPU6z5rmZV3k5+5Hoio8WvZAorzqdIzidjpWkMtFhOAC+7E+b/KZHxo8Luto+gXc99cOzdN3RKIcQh2t8KZtLARpqwZwmo7tDtvsbednTd6HdseP2tc0M7rUpP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6OgwAYwqbRsVMQf5JMU7Q+D77OixzL79nenxAUlHvI=;
 b=CE5o+eDd5hUIA3WwP1pNT7QTucl5FgmyjTEnMX/jW3TVbz3MMCJlB6F02yN8AX9IcjbxU2WDHoV9gGb2nRHBNUh2SzUpU9my83NFZBBTbKsH7+Bdre06AipgEStBa21mnARgQ69/wzs69E/lpg6GAtTS4TXQZTHOpF0o6OfRxZVqGZ3z72qL2TtzDpgUF4uZ0pIRv7HiqWYre2vs35Jl9CRz/5VsKlTxEh9eAywk4f7mfj9oWwlZ1jn2jheiW41ERFObgkwX9E2IYBX95a0HY31xXeD7+Q+y6HMfcss1YDVEUEBwa+buBORoDBKxSaodLhSnPSDyyHfY2Pr7hr0+vg==
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:eb::11)
 by PAXP195MB1487.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:28d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 19:55:11 +0000
Received: from BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e]) by BESP195MB2851.EURP195.PROD.OUTLOOK.COM
 ([fe80::b263:ce33:cd7d:676e%2]) with mapi id 15.20.9182.017; Tue, 14 Oct 2025
 19:55:11 +0000
From: Mohamed Akram <mohd.akram@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] file-posix: Fix handling of APFS clones
Thread-Topic: [PATCH] file-posix: Fix handling of APFS clones
Thread-Index: AQHcPURzLj99TYyeNU+jHWnUq3QX9g==
Date: Tue, 14 Oct 2025 19:55:11 +0000
Message-ID: <AFE31528-83DE-4395-815C-C319E7B1B4DC@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BESP195MB2851:EE_|PAXP195MB1487:EE_
x-ms-office365-filtering-correlation-id: 9a0de394-101f-41b5-dd96-08de0b5b95f6
x-ms-exchange-slblob-mailprops: vuaKsetfIZlps6CageNK96R3p6oJJ6xNNUnCwjXX4kRoC9ifIqIS4G+gKriVhvKQbitYg9yqVEPOWSSDpaXQAhlEYXffsXbSD+d/U8I5dB03DKGkAOX3QoP3hrY/MiefwgVQ3vqbMbzigiHzd/vuWsiNoKhJmcGNKGVjLBlULkezOrtzwQBS471spAcas8/qFlhqDjgG3qPpAdcwkn6VgauTBFfmB2umHPRyjGZbOzo0Xe5D3807wlCRKDNg2sPma8mJimP933Avw10WPJNyTFpJNtyQMRvvWxOwL3QwowAqs5WWBaW+x0x09lzSzmfxItQEepUUvy6mFF5l4T6N0S6gHvD3t8VmsMWWZU0bhFZiIlCZ+L5c+l7tGeJFEQ1VbGKqQA2F7uKslXlVixEaqfkGehBSOA/ZBxuoN5jSfTtC9/BzSNwExf/N/Tlqckjcroi95ejvwKZ20CTWIb8xZeZaFCsvKH2Jp6sMqX09ZRgdr+Ed91kcgwxGxnlfoWuP7CQUho0Pb4Z7MVVqWS8fdjV5uj4ZcEUkfOMgLZ6YeROBAbI7CspJSarqxDjvMthjQ5n6KYWNUI5x2fNy+PwedPEwYlj2SL8ucLMjnT4HH2C8lJNyhb4pZ7dwgSE0hn8Tt4y/uhPOPRpYj573iV9GZkbj7mH0ookEbVUcXS/EC8kOg/VHEIG9gFZmjzrG69JtlTNEx1QWB1asotggACU91vlN+RCy+YbkBX6NFu3zO386IxfYeDiHw+TddQb2he4U/+qNkZcuewC9LVgSbJNBezj/sShi/i7bn20605vlFhhvrBANIp1cS708BFsAIoac
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799012|15080799012|8060799015|41001999006|8062599012|461199028|31061999003|39105399003|40105399003|440099028|51005399003|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info: =?us-ascii?Q?DJ1h1slvx1xf8189GO30giZcmMixmGi/G5AHkzBK/cbWcgWgxdKy8wLQLIJT?=
 =?us-ascii?Q?5WJtxoy5v1xWsgvFJHPuUaNJRinfXt0cJt9QWZ4W12+izZ2XmgDEEAQMboC1?=
 =?us-ascii?Q?jjMPlKURo5BLw7lViGUISMfWbzTx76StpBMR/+f8OGbUmYT/4GjMfDVIZu2m?=
 =?us-ascii?Q?v6UAcqqZoz9MIdeIrdz29bbhwqVuCQ7TGuU31fKOLEG3pMdyrtbaYDxXcfJB?=
 =?us-ascii?Q?VIE3fCjB1dx0UEYaXpuqF4EOHgRpw02dvlkgA4aRlGJjjWryeXKe1Dv8Omtz?=
 =?us-ascii?Q?mqubytpaR0hqsQ7K7s3peCCsq67kDKlMEXpKz+S11VYVu9j/sFvNCoKvgNm+?=
 =?us-ascii?Q?q2iv778/U8sbVT/uD5nXBGSRVymA3XcjxHPZhE/lkr6MMYlAjOtM9Lupf2JT?=
 =?us-ascii?Q?tO8jhgTd4Gj9++JFzvr5R6WLYzn6yZguSTBX1O/nR4IipSwLCi/n734lelXf?=
 =?us-ascii?Q?upmfR9KrRUAePhFzS2e6FlYxdNd4WTt/0p1Oj+OLUroykRk6i7onRQmFBfSN?=
 =?us-ascii?Q?Fxzzxpf4XKIt/7eJd6yOOEzuUrJRU2QcTiOsjt4GMGCL9pzTb1oIG5uWYktf?=
 =?us-ascii?Q?Gf4jNroQAkI/w95Bqhoae+NkqbdzGhhNlAkV8SmDxMcFvCHYVivED4Tasycq?=
 =?us-ascii?Q?JEtd7EPuz2nDEoI9R/Sqd2UdrEcVfQfetLjMhRy6d2QddPncx7mZuxuORoUt?=
 =?us-ascii?Q?e4jorSYCVRp0wIEIGULNWnEWABcyyhxkrhlY8KWJaH1+IC5Wx6NFS39gaklS?=
 =?us-ascii?Q?rJcUQBxIlnIseRAgq+5mmu3NJicFd+9uVAQmxBMPOD3KiC1TfhkLbluhXyZa?=
 =?us-ascii?Q?HVIWhX/0KMnJBQ4lc3kiwHILv1n4vrJgqdHs4VfLcFaEWbikLiTRrsDku0c9?=
 =?us-ascii?Q?OacnXGELScW/q7fbiTHpBRCY/jfcEo7POeuEsdmhwyUO0dRW/shUz2x3/LWX?=
 =?us-ascii?Q?etoT3FTZ0M21Nlu7trKg/olBvWLcsUASD2VPgqvCg2eHuQ7RPEbl57cUg1c4?=
 =?us-ascii?Q?XuDFgDdZSJYATmgpCDjeebtF6IjB0ehXrust1q1dupVz2XWBupnH6jdUfw5h?=
 =?us-ascii?Q?7DgNLaE3PQtN9Qucb/15fBzMEWOsM+tqMRVjuRyD16Qpp8peBvqkzzQIqpxE?=
 =?us-ascii?Q?RVMwJy5CnDqlYnlTcC3HZgwwhiDpMqG9NcuWPXYusmRgHP9RUChC0CMtJz9i?=
 =?us-ascii?Q?jPMdYUtqAi358DpHeb3hyTTamSvElgTwpMLvtb5YwSohUkprn81emrxp2KPJ?=
 =?us-ascii?Q?vSwLWlGYvfh9iWI8B7KTPmlJOM39A82T+7x1azYntyfGzH/hae/rHAZpUVrZ?=
 =?us-ascii?Q?WMmCqCmJXarFY7m7yerlChqi?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vXCR78Pa8meIx5DKt9494XuRInA8Ya6dQiuaYBkBwx90KQTWWSoxGTw5bpxW?=
 =?us-ascii?Q?DIfykQD1aH1kxQ11kKjlvTFaT2/C6dynXykNLg4yWZ5W59MbhPAqMTH3JW/3?=
 =?us-ascii?Q?rGVAsd8lDNWdYtQXSIKq2ZpvfPYHTX2FyhcRBP71wNHRpvcst9kXvMw5/4zC?=
 =?us-ascii?Q?2xt86SmNjU6yqYmN1LDx1bj1jbPdBcxOs99hpFQcEJFlwmF8aPrxmSiFfsYs?=
 =?us-ascii?Q?xVfb6sqJr9fiwJBnLg8iQcLfbwgBF+x9Ek7e5tLBdfAWbRj/XNswmjKSHAf5?=
 =?us-ascii?Q?fV0VNX/MwkkjtdFz8tfWm0DK1MQ0DSNE4jhofIXSYzy3GcWMlk+FmuR+QyDW?=
 =?us-ascii?Q?YzPYSHY1XQnsqE5xw9qDp9C0/2Prq4xxVIOrxS1NkKw+hrXx9tbd/LJHl+zx?=
 =?us-ascii?Q?ccwAfndH8JzN6qcjgYGKvnsvaOA8B3oGxN068HbTvjTYe9/lbQ0UzbpRyHPd?=
 =?us-ascii?Q?KyA0yg62noIBXG8U4oXyVHeqYGvP74L3hefGz04v9obj4jR9Ee6ahPBydHBU?=
 =?us-ascii?Q?zig272ybEkfqY6lVSogd/2x8L34Tg7fbYJeS+BlC9vARXunC28ogk/6uescV?=
 =?us-ascii?Q?MuSIaj+n/ynZVCJSoBbowYspqJgptc8/9oWolAb4oMpPoP2C/kyogzZDqb9J?=
 =?us-ascii?Q?o7dvRUSmpPd4U+qK7QQYnbyI5KuKwZDDVYkwK7hZS71uuGe3PWiDhP/HSoJj?=
 =?us-ascii?Q?JlqBNqB2TbhzTpM1kO8qVry7mBEUn6k1kb35ToUoJuG5o0jcThPeb/6Ly/U0?=
 =?us-ascii?Q?YkMVa4CMhovRfNk1wiK+pxPUZZFRUjFTrFDiXniJoBKW+Ri+SkSR0+0NbkOl?=
 =?us-ascii?Q?0W1Kc3DR94co6UNFqZ0wyWUdNHp0iqOwQOpQF7gJzAAhtbs8Gbj2lj15d/vo?=
 =?us-ascii?Q?yeiH+vSdMe4w0Qb5qArDFCGwEl9XYYKfLYN6cLHA+JhzcELKW6ojrP26bt7O?=
 =?us-ascii?Q?P2BJ3Dkjm2cEM+fq7M8pSe8vmEZ3p/SqUutXnsyGNDB+vJpTQl0NNhnp/Jy9?=
 =?us-ascii?Q?9UWy1OwDDYADXAajr3DDKw7779sRelsBagjfthlnT4IvSUg3DQKk8DU1G4Jo?=
 =?us-ascii?Q?55tedU1xF2QexBL7IU/PKFueqIfGeOV8zWPjCXssSVpSv3z1ICszK+XMOVsn?=
 =?us-ascii?Q?P6CUnU6Tvwsb++b4owIt5L859PTeT2BZ5p6Jz67jik7cHNkEr9fNo28UijAx?=
 =?us-ascii?Q?Leb3idp635G4fk2NLu2Vw0TFnOLd7Huw0WE6ORMQaGCeYUeSGpC70bZxAX82?=
 =?us-ascii?Q?5sMgGWEn6FwdDmEOtzF7kS/xthWdRZqqtflpXZcJAMYG/wdBWaiheYVcQw//?=
 =?us-ascii?Q?PHU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E43607F0266DE48A91F65D44FC0A032@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BESP195MB2851.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0de394-101f-41b5-dd96-08de0b5b95f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 19:55:11.8775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1487
Received-SPF: pass client-ip=52.103.51.82; envelope-from=mohd.akram@outlook.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On macOS, lseek may not always report a trailing hole, in which case
seeking with SEEK_HOLE or SEEK_DATA will fail with ENXIO. Detect this
condition by checking if errno is set to ENXIO even with a valid offset
and return ENOTSUP instead so that it can be correctly handled rather
than the file being considered empty.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3124
Signed-off-by: Mohamed Akram <mohd.akram@outlook.com>
---
 block/file-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8c738674c..89b3e338c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3190,6 +3190,20 @@ static int find_allocation(BlockDriverState *bs, off=
_t start,
     BDRVRawState *s =3D bs->opaque;
     off_t offs;
=20
+    /*
+     * When using SEEK_HOLE on macOS, if errno is ENXIO even if start is n=
ot
+     * beyond EOF, then SEEK_HOLE and SEEK_DATA aren't supported for this =
file.
+     */
+#ifdef __APPLE__
+    offs =3D lseek(s->fd, start, SEEK_HOLE);
+    if (offs < 0) {
+        if (errno =3D=3D ENXIO && start < bs->total_sectors * BDRV_SECTOR_=
SIZE) {
+            return -ENOTSUP;
+        }
+        return -errno;
+    }
+#endif
+
     /*
      * SEEK_DATA cases:
      * D1. offs =3D=3D start: start is in data
--=20
2.51.0


