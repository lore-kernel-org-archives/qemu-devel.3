Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=kgDfz5+Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQSU-0006qw-O5; Mon, 09 Nov 2026 09:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQQSG-0006qU-8C; Mon, 09 Nov 2026 09:34:40 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQQSD-0004c0-TX; Mon, 09 Nov 2026 09:34:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMOfQzsETK7T+rX0Ncb+qDKvxfpRIG8G9cKOYm3jj5XNM/pqB+9FiWwzjiEMvwpxHK/Rx/I5GXF7Pp+S4kZKgFR3VdY5M/IbQmG4LB0iK/gQ+1ISfqMNzBqWl+AMV2rsZzLLoFcL0T5dvmXuDty6wpav+8dLXl/yY12Dusx+zHJEkRXgfRhAaq666RzCsnbAHiiZ1rYLaNyMSQakK+XGbh5geLqdmYRvk26BFIqVnOdfrtFsiy2XYLm3md/jv7kdZEs8Ct2D25tz4B2v3PslfPmD18CkW5DclWoOL1GEdgvlzWRJuxtrESw7nrN5nouq7ZsutbxG/kb6XfICNtnZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRLvUPNef6V6MsCFcrN76zh1nvc9A0W7IsABuJYn2s0=;
 b=vXIX4tl9BcrzBjlRbMlHGiLG+FIF5hYtqNYZrun3htMmbJJkOEZL+f9nja2hM/zlrWVewY+3mc4nna94O3jq+5BE0aeJI/dKzaR4vhp3kH7lnd1p0jP0CNeoBiRL/aq9Rmr1jkQ3N7w9BXaEmtGsX8rHiEqAOkFkQ+JW+2k1vHLIuhTf03JC13CF802i6p4s82nq+EReDxAKKgYHrnTPIvvzkEf5of0NSjvLhlOoLcUI1OvdEo1jGSXamerI50UU1AkhMbMzRdQiRhdXK6OrxLnWQ5FADBHzKnr6Sj5ZbOISudBptz860PWuiJQMhDJ4JkimU6If83/f+zQQkfjYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRLvUPNef6V6MsCFcrN76zh1nvc9A0W7IsABuJYn2s0=;
 b=kgDfz5+YiYaL26v/KuesdnLN/kG/j9bXHaJdagZY6AO7aQ+kT13o9Xaa1DELOM37qYkPOztS/mTqJiVR6d0TlCkFAehBLK5RPj2iOUgsAKLKzjN1gQqVUigB7LoX+ibNjufIFFVpkAOAZGYYWkbtVJD/MiRae+5biV7/ROugHg1eUxZb368BiKxTkzjS/V/Z9asKVESCzu5uovmElvbppGK3V5elZWxv3FWjLXTWozsU1Eqihp1M727tJUUSZFLqlwKwaX0eDP9QyCrOHfoW2VY3P2xhI53o6hboaFf3R4sLqBvhRcCUhD+nu+FmbESyzxMl50033+mzzm04jwZuYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SI2PR02MB5515.apcprd02.prod.outlook.com (2603:1096:4:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 14:34:26 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 14:34:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3] hw/net: cadence: Honor subword lanes in the GEM registers
Date: Mon,  9 Nov 2026 22:34:09 +0800
Message-ID: <20261109143410.3279305-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SI2PR02MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 6512d204-be08-4a9a-5225-08df3e6e8d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261026121527099003|261021121427099003|56012099006|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: WuvYY55EWx/IZBtg4COX3HT7jjLHA5gxCuKxod0wcdvWuEg4i/c/c08KYwBk22eaje3McPTipVjNoHmUYk1zSl0V+KhvB8gef+AmOe0uZZ9tcHIMCT/TjRrcOSyjL6IpdpoR2jqyXkiTjCQscHZ70nhnGlmR1hd3bpVFJrMY/lRianVXEp4VOdVA4u7tQtcQBrGYuBvc6OTVV+ySZEkLQLHlv5FZcB/ph69NmvpuntfoN0l39Abw1jz23rsD0sfEfTGy/eAZgelyK+5Dp3JYvLoyNQGbkOZGFF1ru+bBdWHYnF8WmJ192ZzQ+wjVl1ZLCzJyuEMFAmi6+yFx+DioPa4mMSfMxEm+IZn5FdN7vMrSOq9WyMxSchpdhUaAyRTpHcHb/kdAYreWb3AiBhagEMsxGy/8JacUlf+dLv3PwHG839Q1xZOQW5+3HT0qwfn9qn35BfIfqCemd4UbQoWCoc3KD3pXcmCIrao5D7sUBn6+4XvU4uk2toClSCQbgOJrXMcK3bpGV3nFVTuXCEUPn+YaU3Kc1oho67vK8eldHM8j9vT+dSiAzhsbHPBDPbgYCzt9tRtQfvaRq9RlSylssWcKhW0J5LYlQ+4ZG1nKUVvjwgeZOjkn6dLi+u3Qi8JsNjCdaBu7aYEbAMjnLD0yu1KGo4UuNFqAFjIb0YKz/JE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261026121527099003)(261021121427099003)(56012099006)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmwwTENHNldjRThnZ0YvTUFHdU5ZTkpjSllUNEtjVTlPYTdNOVZWajYzYTJx?=
 =?utf-8?B?dUtYaVRQNk1jYnJveEhLeUJGRXp3dWNYUG9nakZkdTl4NW9ySHFqQ2kza0NB?=
 =?utf-8?B?aTRuUlBpdFdxMG9zS0d3bTRUM0VxeE96T0VTcjVOcC8vZVZKWUg4OWZRbjVX?=
 =?utf-8?B?dG1rVEJuRUV6aFdudWVyMnJkVVMyOHNJcVNOR0tqTm81L1hOdmlhUzNTdjhv?=
 =?utf-8?B?eEV3eUZvd0FVOHhwRldWR0drVEcwUEpNdUlBZkpWa25ka1FuaW9ZWS9kTTdB?=
 =?utf-8?B?MW1yYzRBMDR1WmQ1cDNId0JmS3VKaHhpN21qcXc5cjJQaG1zdk94R3Y2ejNW?=
 =?utf-8?B?R0p6VkpHbXc5YkszblBCblJoZFVvaTUrNEgvb0thQTM0UUhwM3VqajJnNlJD?=
 =?utf-8?B?OG9FTGs0RlBjTm5EbENLa0NCeUhPSjZ1Q1Uvc0puY1BWVXNpclRRMFZxQW5I?=
 =?utf-8?B?TUtyR2UzS21ucVNMaXRaai9abmcvWlQrZ0hEVjcwdFE1ditpUGxIK3JLNis0?=
 =?utf-8?B?NHNpdmprUVA5eU1TeXlvOFpZczAwalZoZ3lhZmNvNE4vZC9jdjlGTC9zTm9K?=
 =?utf-8?B?ODdCOTA4RG5WQlNNZENOTy9QYmgreVZDVGN5dEVWTitpbzNiSEJmTDVCUXNE?=
 =?utf-8?B?VUE4bUJnSnFDenJZby9NNURDOWtBVjNmUUdKZzJyaVpDaCt5ZmlpOTkyeCtE?=
 =?utf-8?B?SVpaRUhDSW05bGhrV3Vqdmxla3lRelY0anorb1pUWWhEK2N6dWJ0L0I5Sm00?=
 =?utf-8?B?NEFYRkVJRHNVYngwSXZ0bHUzUWpRYyttMlpxVmhFcElCcTZTck81d3llTTVR?=
 =?utf-8?B?L3BEVHNMRk9SZWlzSEVtRmxqZXZWYW9OWEJzN3Y5L3RqS3JKbVhlZ3hJVkE5?=
 =?utf-8?B?TmRMZ0FtUUY5MUVVenI5M0tmUWJBUElxbXBoSFpVTkFVSHhqRW90YXc2MDRR?=
 =?utf-8?B?SElGTGNwc3JzWnc3cWlOZkI2RWtXN0NPYm9yOEFNbnEwS2dxRHEyVWFJRG5t?=
 =?utf-8?B?dWs2YlNCS1lYSHViazlqb1FiNmI0Nzl4UHM4a1Q3TVlWRFA3bmFEc3djWkIy?=
 =?utf-8?B?Vzd4NG8rbzVsQTVKUUJvYzhlM216MG82YW5iYjJveUJUNkVnK3RTOWpwYUdX?=
 =?utf-8?B?L3FUTGREWGR2MEhpTWlOY0wxWFgybnBSMlhwT1ZtZCt6QmxNYXlBdnBvOXl0?=
 =?utf-8?B?Y1dMbFRhcitsS25oVHBjUjNTRWtDcDB6OGJ4TE1ZM0I0TjE2Rjg5VXcrRits?=
 =?utf-8?B?cDB4UCtDZGRnY1BmdCtXdEx0RWQ4RnNEVytKTVF6dUVocUMyWHRrNDY0Yy8v?=
 =?utf-8?B?elozVDRHYlI2VkkvQVRDaERzNUFRdE4wZWwrUTh6YzhYQ1BpbVJzR0ROWlJ5?=
 =?utf-8?B?b0NabENwMVFrcDFxbTlEdFpZbEVuTkVSRUpVUGl0eTZNNFVEQTNBMWFaeXYx?=
 =?utf-8?B?TnR4V2NndFp2M0xlanIwRXNBZFEwb3crZVEwcElKTVBiY0N4MC9hcEJSWFJo?=
 =?utf-8?B?UHhDRVhZbzhPQlMyZlZnRUZuZFkrYnN3SjVqQ2JjanZacjM3T2dmcERNOXRm?=
 =?utf-8?B?Y096eFRCRmwwRGJVN3AveCswcHNvQlYreDg2a08xcFR5NERLbUE0bzZUV1pW?=
 =?utf-8?B?SnNNVDBIWDBqTGJ6MDZ0dHJFV0FTUWgwenhpWEVwSEdtTXpnWDljOVMzUXgv?=
 =?utf-8?B?QjF6WnVSai83VzFYbWR4ZDZpTDJnT3Q5MEZTVTUvdHNLdFVEL1R5T29leVhH?=
 =?utf-8?B?UW5pWmIxWUtjK2w3bmJCSUtoUWVPTllhWDFZV3hpNWpxVTIxK1dpNUxWMlRP?=
 =?utf-8?B?ZHFsdmtoalBLU3ZucFVzMWFVMnA2amhoTW5ZZGk3M3l4MWN3VVZzT3U3Z3BD?=
 =?utf-8?B?YXl2d1FEZmt4ODNwL2FSUE9ZU29vdXZEYStiRzlmdDVjeEtqWmJNV1UzZU4z?=
 =?utf-8?B?WFB3Wkg1MEtFUWIrS0F5eFNmU2FJU3RvWkFvZ1JMRmhkS1dQZXRQMUtBSmpv?=
 =?utf-8?B?Q3pwRk8vNUFuSmJmVk9RM0l0Q1lHcnZaNklvTjhSM29nemhkcmNkalZOellr?=
 =?utf-8?B?clIvcnpBcTVNYmtjaERGanFRckVMOFVJQnNJcGZEd3NTTlpvcmxlZU0yN2NT?=
 =?utf-8?B?eUNNTzRpNHk0Q0dpbWM5ZCtwSUZ5K1FZQW8yRnRwUENMbGdVditpZUNTUEpO?=
 =?utf-8?B?cjhiWmJEZmxUOXhrZVdRdXQ5VzNQeHNVOUVQa0xEcjNHZk9YR0JENlduc1hi?=
 =?utf-8?B?ZW9FRXdPcktZZHNDd2NsUHNuTEhOMHF2dkhxNU1kUFpUVnI0YUZCUmQzMjZR?=
 =?utf-8?B?Q2h1TzFIK1BrRFhUOG15d25UZ21Ba1RZbFBxbmpzbEFJMXZZZUtycGxlVGY1?=
 =?utf-8?Q?hLL9kNvxMyajEnD4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6512d204-be08-4a9a-5225-08df3e6e8d87
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:34:25.3775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFNj6LHyAZ7wmwt30oxIWB0o8neNT0nCBJq2O4CUOfiLvGlCmAeITEBO9VjZtGa+7ab5XPsEG3jPqYIvNMuMOeeVqi6Mj4FpLTXDRFhKkxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5515
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GEM MMIO callbacks ignored the low address bits and access size.
Byte reads therefore always returned lane zero, causing guest driver
that reads the station address byte by byte to turn four unique MAC
addresses into the same value. Partial writes had the corresponding
lane-selection problem.

Extract the requested little-endian read lane and merge partial writes
with the current register value. Preserve the existing read-clear and
write-clear behavior and dynamic queue pointer readback.

With this change, reset the TX queue pointers only when a write covers
TX-enable and leaves it clear, and only start a PHY operation when a
write covers the OP/ST fields in the PHY maintenance register.

Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---

Changes in v3:
- Describe the TX-enable check and PHY operation trigger

Changes in v2:
- drop the gem_get_register() helper

 hw/net/cadence_gem.c | 55 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 9a94b3b8ca..7456f0e18e 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1603,8 +1603,11 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 {
     CadenceGEMState *s;
     uint32_t retval;
+    unsigned shift;
+
     s = opaque;
 
+    shift = (offset & 3) * 8;
     offset >>= 2;
     retval = s->regs[offset];
 
@@ -1638,7 +1641,7 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
 
     DB_PRINT("0x%08x\n", retval);
     gem_update_int_status(s);
-    return retval;
+    return extract32(retval, shift, size * 8);
 }
 
 /*
@@ -1649,35 +1652,43 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         unsigned size)
 {
     CadenceGEMState *s = (CadenceGEMState *)opaque;
-    uint32_t readonly;
+    uint32_t access_mask;
+    uint32_t writable_mask;
+    uint32_t write_val;
+    unsigned shift;
     int i;
 
     DB_PRINT("offset: 0x%04x write: 0x%08x ", (unsigned)offset, (unsigned)val);
+    shift = (offset & 3) * 8;
+    access_mask = MAKE_64BIT_MASK(shift, size * 8);
+    write_val = (uint32_t)val << shift;
     offset >>= 2;
 
     /* Squash bits which are read only in write value */
-    val &= ~(s->regs_ro[offset]);
-    /* Preserve (only) bits which are read only and wtc in register */
-    readonly = s->regs[offset] & (s->regs_ro[offset] | s->regs_w1c[offset]);
+    write_val &= ~(s->regs_ro[offset]);
 
-    /* Copy register write to backing store */
-    s->regs[offset] = (val & ~s->regs_w1c[offset]) | readonly;
+    /* Copy writable bits in the accessed lanes to the backing store */
+    writable_mask = access_mask &
+                    ~(s->regs_ro[offset] | s->regs_w1c[offset]);
+    s->regs[offset] = (s->regs[offset] & ~writable_mask) |
+                      (write_val & writable_mask);
 
     /* do w1c */
-    s->regs[offset] &= ~(s->regs_w1c[offset] & val);
+    s->regs[offset] &= ~(s->regs_w1c[offset] & write_val);
 
     /* Handle register write side effects */
     switch (offset) {
     case R_NWCTRL:
-        if (FIELD_EX32(val, NWCTRL, ENABLE_RECEIVE)) {
+        if (FIELD_EX32(write_val, NWCTRL, ENABLE_RECEIVE)) {
             for (i = 0; i < s->num_priority_queues; ++i) {
                 gem_get_rx_desc(s, i);
             }
         }
-        if (FIELD_EX32(val, NWCTRL, TRANSMIT_START)) {
+        if (FIELD_EX32(write_val, NWCTRL, TRANSMIT_START)) {
             gem_transmit(s);
         }
-        if (!(FIELD_EX32(val, NWCTRL, ENABLE_TRANSMIT))) {
+        if ((access_mask & R_NWCTRL_ENABLE_TRANSMIT_MASK) &&
+            !(FIELD_EX32(s->regs[offset], NWCTRL, ENABLE_TRANSMIT))) {
             /* Reset to start of Q when transmit disabled. */
             for (i = 0; i < s->num_priority_queues; i++) {
                 s->tx_desc_addr[i] = gem_get_tx_queue_base_addr(s, i);
@@ -1692,37 +1703,37 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         gem_update_int_status(s);
         break;
     case R_RXQBASE:
-        s->rx_desc_addr[0] = val;
+        s->rx_desc_addr[0] = s->regs[offset];
         break;
     case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
-        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = val;
+        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] = s->regs[offset];
         break;
     case R_TXQBASE:
-        s->tx_desc_addr[0] = val;
+        s->tx_desc_addr[0] = s->regs[offset];
         break;
     case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
-        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = val;
+        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] = s->regs[offset];
         break;
     case R_RXSTATUS:
         gem_update_int_status(s);
         break;
     case R_IER:
-        s->regs[R_IMR] &= ~val;
+        s->regs[R_IMR] &= ~write_val;
         gem_update_int_status(s);
         break;
     case R_JUMBO_MAX_LEN:
-        s->regs[R_JUMBO_MAX_LEN] = val & MAX_JUMBO_FRAME_SIZE_MASK;
+        s->regs[R_JUMBO_MAX_LEN] &= MAX_JUMBO_FRAME_SIZE_MASK;
         break;
     case R_INT_Q1_ENABLE ... R_INT_Q7_ENABLE:
-        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~val;
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &= ~write_val;
         gem_update_int_status(s);
         break;
     case R_IDR:
-        s->regs[R_IMR] |= val;
+        s->regs[R_IMR] |= write_val;
         gem_update_int_status(s);
         break;
     case R_INT_Q1_DISABLE ... R_INT_Q7_DISABLE:
-        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= val;
+        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |= write_val;
         gem_update_int_status(s);
         break;
     case R_SPADDR1LO:
@@ -1738,7 +1749,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
         s->sar_active[(offset - R_SPADDR1HI) / 2] = true;
         break;
     case R_PHYMNTNC:
-        gem_handle_phy_access(s);
+        if (access_mask & (R_PHYMNTNC_OP_MASK | R_PHYMNTNC_ST_MASK)) {
+            gem_handle_phy_access(s);
+        }
         break;
     }
 
---
base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
branch: cadence

-- 
2.53.0


