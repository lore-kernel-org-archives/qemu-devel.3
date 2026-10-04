Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8EECA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIAd-00062n-Lz; Sun, 04 Oct 2026 05:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIAB-0005ud-43; Sun, 04 Oct 2026 05:05:46 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA7-0005jQ-Hg; Sun, 04 Oct 2026 05:05:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEKRLjxuyGH0SO+bhLuzH1gDHjksOB4jXgEohKAKSQH29rtvRa76otlBDLATTjtR79zdT9NdggyPP9kXiIMP1nND+bb3P+cw6ZU5vLl2LXn3vx8MVfhn9rmV7pwJhxgHOIXdTEnglOPSzmGGhMGgzTqcoddms2RrnFpDe8lAXgXkFjo1+O2gvmtwJZfUNJNIzGn3oibnTqcHhcFx4Nq7KolPwBulG0EQ6m069fHkFMKmrYrX7WVBIS4/nhQ+V4VhPftdykkxOB8ahioxxSY/5++oopHG0arAK2k0VM9VMGMDM2gMqluDsiaPzz6ulcijOWQ+jSWiv6rxOgBQUI2PEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQfCIvvSOMqLH7ujYlg0XoS6Wc/jntvLfNW0sokJ1bo=;
 b=adwz70fl0i+x219o6JrB/h7dLWus7SXbrZxH3qxYzDWCQf1UrimwOqcqNiU+3bLJeaQbrAdNsC6o78pdpQCKtMBXL1V10FjcUrlrvNPL+9vxS4D6UfrkmkLo+Viz1B8m/wGWjOqXbQx+B+jt0zPmJs63EmumBYUKcBq0RFobRWYXC/b8mLzkbY8ieT5voC4iZRf8xxgprkDZyPPr7vqZe3IUZB8aCMSIBtvLoA7DGr1mZV0aLFATCGDA9MnypNDRjOhr9IFtE1BdVzGvOBuoP03dwuA1tZ0CHODLJG8Sd+9xsUjVZERWgklToQ+yEHk8I7MtjVgA/5LLRunUwZCoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQfCIvvSOMqLH7ujYlg0XoS6Wc/jntvLfNW0sokJ1bo=;
 b=oBWLZ8PecuJwjH7t2cwi2SUUxKVvZoe8ayzhgF4e4a0w0aASu/OyVebdS1z5qBAPiCV/wXEv7ZIW/uzSN7riSOAjHTWlcm1ptQyq3n9nRJ0WqCZleIEeLE1N28uNLdpw9J/owSygEZA4KvHnwA70ogpNvWpHqQBjDQLbGXcQ95waFyBy4QOQ/UuzX+WuhpsXROmkjmTDK6Gf8tx/zho3HMqIoRn34FHvuTRkb/gvpF4XyyotwhQxqfGaQILKu6e2t/09FIYIKX7yKjYdNFjMoJgPTLaiAwKqU90LH+iwXzy0ndZPLVJQ5Kr+3lhqW1hYKSeDk3QEuK/xBgx8dthgiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:31 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:31 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 07/10] hw/sd: sdhci: Preserve uSDHC status enables for
 U-Boot
Date: Sun,  4 Oct 2026 17:04:52 +0800
Message-ID: <20261004090500.3082641-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 18dffc21-6c2e-4df6-fe06-08df21f6a427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: XLHRJ+UNOsrwX1dQ34XlxmrZzxHrICg99BCWNy2D27n3PPNy/G04xgUV/Iof/rfTUzPezQRlK2DGUfn7s5ncZfsj1Mvcvwy8WxFRc+hFnOcIEJR5/qo4eDQZfbqk/juuDnXhRPmvX0Rnmv122XK4glxZDYObCA8FBIuyZDcp1Dd0H8/saBjSPJuYM3V/5HtSfZYaY1mRNaVT84OhQneOmoAsLVmVeXcLTl9fboSr6wbtF7uRQNAl9tgkWrpnFjvRAbXphr2Hvx7EweXqY2KykB/LxtLoSPI8WsQU7h0pvZnm5br4uIaziDKmLfvdmMdcJSkkpwZKoiND0p0pUdQodnYGGuA5dZaVcRa5IxpUhBKXaSY7NXJtlpYx8bxGMGnd+YF6Hy+IxxcM3Xo8Es5fiY+HyygCVNCQuX9nvlXP0lcbKK7K2F3VUgGMxnd4OSvJUm6ecVK/MYYF5GIPLWE25/LBu85+JXbSzj+hVuj+4T+29frkfMHrP7kvSlyvSzKzMjk1N1ZtIeubJM/4KBp2LgZMSyDrreV19p7GSlaKijV22qmbR8zoyf0gcMeiF1YwxEED5XXHmNOzMU71FdutatwzkfVGJABK5IM0N2ibI+bK29aoyc8xE0Q7kbPIg/km+ia2furZrV4xmANC+CM+wVlYYxIjIpI6eZafdWPJO6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eovP29ccrm4hY4LQXuhb5u/uMtSwvIHorvhj/2dOxsLaRXeO4bNC5yz2ZG2n?=
 =?us-ascii?Q?Av0MXX4g8IoaTioSwpwh7V51N/dpWoJ7C9dBtxc14ZjUik0EoXmian/hw5OM?=
 =?us-ascii?Q?HpZMiDLhFDKRU7sFWdjjfXvlLHXc+gFTrgF58YnDVeKJg049HHdRhRinZZjj?=
 =?us-ascii?Q?RzPmhe0UouGy7AYHDlFzH1lfcl2ap7V6WzIb/Lmf6yr1mJj6RSgB9oSaJfRX?=
 =?us-ascii?Q?DmXP/pNvjEEzZLkaEqbKsPRcyRgkeEpXYUzw7O8Q4nT7hPDTqIZL3u7LH+Ll?=
 =?us-ascii?Q?x2qUihsl1L0jtR+ERPfMdztXBXg5LbH8RE6gk8JAtA5vM+6zRHcMylT0qRon?=
 =?us-ascii?Q?nn7K4vdUQPbduuMaCbfZTV+SEM5kEjcyMUyIc65vkyEa8WwhBAF/OlW/PMVV?=
 =?us-ascii?Q?h1E1MVCyOThzW4DEHUQsFlBHKtBwNfOAFw3y0HiAWHIzk0YOdt+jGRhvjZ3O?=
 =?us-ascii?Q?FknefDny2St5JcilrdrnIKmLPQdwi2vCHbQMpX0xCb0W01kYxXAzVL1UVhgp?=
 =?us-ascii?Q?yhyJpkMqCKP/mIXnbszKIFOmdRpBql/fI3LpG1eUFZHhP8RuKNfvNLlJh7z+?=
 =?us-ascii?Q?X/Mw4YkySuKTSD6LeJNKkgPgi7X0SBSOu1UqUcfeT/KRHrUM5deE1Uzdk3GU?=
 =?us-ascii?Q?3W2S0dKsFSJYplT0SsDgp7hClGlBnpSo4iRKWYEHT98mBhwJq8nN1S3JxBDv?=
 =?us-ascii?Q?bHo2QStXoET/NSNkvKU0rYvwiwjQT7pEOlcfRMURkcxHz2RbjvlsmRMXiERI?=
 =?us-ascii?Q?VIDKp3vv3/y34NwJ82LI2odSzjUfZU8jAvXtyU8Wx76LTjiK4nOhMEojCpwX?=
 =?us-ascii?Q?dOFXxscugfjDbg4XLO+Jf6eb1GQqjVB68hsOdKmw4zG6nrEDlPWgIF19sgpe?=
 =?us-ascii?Q?fJa65SVjixjadHHwgIUB0CYsMwzD3PMDCTL1jP3IrV7JnymuhqtGzQ6vZOai?=
 =?us-ascii?Q?X8PtqBKEDkjAEYUM9q8ldFVW0GkHoeW9x1T6aPgHlTxXHlv5NzdwRy9uLtnK?=
 =?us-ascii?Q?OW+352pPj9txBwYXtFGJPOfrpjLDPHlfsNwJzM14Fwi5cluzNSE4SEXi/+s3?=
 =?us-ascii?Q?BP4Jr4KVWj9xd2jY9sohJxehY+BCVEcbhh0qZ2Qm/aF3IDcoID7uo83PbFDS?=
 =?us-ascii?Q?AgLQfAEgEGGcZnD5UOdW7xdDYzvxkInAGFP5CxJbb9PA9TJMq94GWfZAvDLa?=
 =?us-ascii?Q?2VxBBZ5icUZFSpPxpclb4QbXVvMpfmiMSrropMMPjy5adQw9Lz0g4dZiNKzu?=
 =?us-ascii?Q?BEiYVnF9BFjeA59W3udpInQYPq0iZ4Rt8rsXXnPjIMq06VxIPcCseKLIcwmd?=
 =?us-ascii?Q?MitVPEUK9dz9ykINSTfBZkKbobHl8lyYVxe2fJUl+yCKpUwaI6nbo5+PhuGm?=
 =?us-ascii?Q?7ji12ugH5zRtabvAjt+uQHrJf6mJu4TjxcYiLcEikm3h7uNfCzZ0M+nYvg3F?=
 =?us-ascii?Q?Un8qiGc2oZqaC+yhOZ7TbK3coPH9/7L6LIC4Jc9xh2WAlG6gADlVTAxDbTgu?=
 =?us-ascii?Q?+O+AOsitR+7PhCWqGI6Qpr1OaHsPKP6GbH1SUFSfVe3jHZWty6TJNKi1PR03?=
 =?us-ascii?Q?R20gC12u7eOnij91HdmpmcSHgGxVIUG/drhVrNnOlZcx8oTxhYbi+8qESY7J?=
 =?us-ascii?Q?wXByWNZ1R8jghN2SReiTT1fnArfFmdadc0XQmoZ8Mvie23dDfRZVBe6f9rOk?=
 =?us-ascii?Q?5/UNXnIT21Ivj00Qc2GedkBtI17U18TZhT4NjRTDMkTuFATQ6yAQ7tWihkgP?=
 =?us-ascii?Q?C39kUJeu99QJWrLp6o+FUfBnjbf3vvw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dffc21-6c2e-4df6-fe06-08df21f6a427
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:31.0903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbdesDmWTu8PuiTII16X6VmjWnC3XZFAX58T08IsEUlD1pw2arAPDkC8Rk6jxE1ozgtSs2B4X4KnC7HObuhIxNmUo6AxHBNaEegafT6ptRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
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

U-Boot's i.MX uSDHC probe calls fsl_esdhc_init(), which resets the
controller and programs INT_STATUS_EN. esdhc_init_common() is then
called, which issues a second RSTA and only clears the BRR/BWR
status enables afterward.

The generic SDHCI reset clears QEMU's normal and error status-enable
fields. Consequently, the second RSTA removes command-complete,
transfer-complete, DMA, and error enables. Commands still reach the
card, but QEMU does not latch completion status, so U-Boot times out
and fails to expose an MMC block device.

Preserve the normal and error status-enable fields around RSTA in the
i.MX uSDHC register path. Signal enables still follow the generic reset
because U-Boot disables interrupt signaling and polls INT_STATUS.

The IMX6ULRM describes RSTA as clearing read-write state and does not
document INT_STATUS_EN as reset-persistent. Treat this as compatibility
with U-Boot's established two-reset initialization sequence rather than
as behavior directly specified by the reference manual.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Preserve status enables for byte, halfword and word RSTA writes
- Integrate RSTA handling with the uSDHC clock translation

 hw/sd/sdhci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 40cf407876..3bcad3e518 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1840,6 +1840,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_TUNING_CTRL               0xcc
 #define ESDHC_TUNE_CTRL_STATUS          0x68
 #define ESDHC_WTMK_LVL                  0x44
+#define ESDHC_SYSCTL_RSTA               BIT(24)
 
 /* Undocumented register used by guests working around erratum ERR004536 */
 #define ESDHC_UNDOCUMENTED_REG27        0x6c
@@ -2127,7 +2128,22 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         return;
     }
     if ((offset & ~3) == SDHC_CLKCON) {
+        uint16_t norintstsen = s->norintstsen;
+        uint16_t errintstsen = s->errintstsen;
+        bool reset_all = (val << ((offset & 3) * 8)) & ESDHC_SYSCTL_RSTA;
+
         esdhc_write(opaque, offset, val, size);
+        if (reset_all) {
+            /*
+             * U-Boot programs INT_STATUS_EN before issuing another RSTA.
+             * Preserve status enables for this initialization sequence.
+             * Signal enables and pending status retain generic reset
+             * semantics. This compatibility behavior is not specified
+             * by the reference manual.
+             */
+            s->norintstsen = norintstsen;
+            s->errintstsen = errintstsen;
+        }
         return;
     }
     if ((offset & ~3) == SDHC_TRNMOD) {
-- 
2.53.0


