Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79548C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7dT5-0007DU-7N; Fri, 18 Sep 2026 14:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x7dSp-0007C6-TW; Fri, 18 Sep 2026 14:37:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x7dSn-0005PF-FW; Fri, 18 Sep 2026 14:37:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IH25UR1841337; Fri, 18 Sep 2026 18:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RbiZ+v
 XoC5WIB9vtBZeBnvzctgZm07XFq8bm+Cwr1uo=; b=FlH4Fzdpts9kSqtG0iYN8a
 CVIoNEwZGlEGPDggNWkDULeE1ktRWVwYb5CR4QGUw8xLxNF1mqDtEo53G5k3/E3m
 6706dqObdVBu57kExaCVGxxhxa7IvDUTrOGHs+gQoh3EGoSvDsolbRveY2/R5Gkz
 4Ljjpe8y268W4psNa1SWjML0JPG1MlpUa/J8X7HKu7nmEkNo10Odyfk+gX9B6u97
 gqAVAKPy1Hqkocg731c3CJmOAD7Txgp9Axa0qjfs5icuuyiUWGQt1pmOHxV43ACi
 ugOvDBigUKJX96t8ee6nInoAwnInM5RPAucCRZDTbjz+l0fmC3S0eiaGpbFcv2xg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5ht8u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 18:37:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGovYi983642; Fri, 18 Sep 2026 18:37:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q9fer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 18:37:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68IIbODe29426072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 18:37:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 121A720043;
 Fri, 18 Sep 2026 18:37:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B516820040;
 Fri, 18 Sep 2026 18:37:21 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 18 Sep 2026 18:37:21 +0000 (GMT)
Date: Sat, 19 Sep 2026 00:15:07 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aniket Sahu <asahu1x@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 rathc@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com
Subject: Re: [PATCH v2 1/2] tests/functional/ppc64: extend pseries migration
 tests
Message-ID: <20260918235644.a26929da-e7-amachhiw@linux.ibm.com>
Mail-Followup-To: Aniket Sahu <asahu1x@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 rathc@linux.ibm.com, 
 milesg@linux.ibm.com, harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com, 
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com,
 thuth@redhat.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-2-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916103635.7797-2-asahu1x@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Bnt1adWY2_k0gptI1lIfDQN3T7KGDaqh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfXwh9DY/h+Mavo
 TsAI0uxsJtIRZaZRu7O5j9iVZlx+MsT7e8TRqF9qh84f/Lqy9B3i75mggK8R6PAVEC5BF4ZErT8
 knQMsUzzlA7hPyGlLxMz7fWzBEHbvzk=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aad84e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=YLdZcKxzF52o-ovF538A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: 7HDbNBQC7DaDQLxNiVu1v5ug41D48JJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfX+2h2YGwSqM6y
 rW5npjgU/Lgo6W9742IDPZn5p6XZULkpmwOwuL6Sg35+q/x4NRprJ53Z+US63+1iR92O+5Gw8/W
 a7LdhzFD/UVnWyrUEZBqqG9/Zt0PgV0Xai1orSOpH5nBslrxyQL/tqU5RSaMiR4prgIcxgLFcrZ
 BzBZr55RJBMAY6OgTBxVD6Yuqg3PQpmCZHRKgqlWqxX7EkdZoGNo6x1foTm/YOfVpq2I5yiXvMG
 kwzox8cb6EoeuYoZ6eLIhbLOvjysgrGvyxnORr7QIHJRaeZubFo6EYTAZnB2ggvxpZpmA1wA1K1
 KzE158QNRyl3VC4s3xO+WgWu3kEStXCJOgri9eE1lnQXMqd2xReeAjklOdOvG5yp2kDRmk/+47/
 v2nxKihi5H4JYz5UW174J649Qsatuh/w59arYImyttqBpT+zVvckmgNux+9lkHymxBQINoLADXs
 uFGhuTWM+A+T7LjumiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180266
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Aniket,

Thanks for the patches.  Please find my comments inline below.

On 2026/09/16 04:06 PM, Aniket Sahu wrote:
> Made a few changes to test_pseries.py to extend the migration
> tests to validate exec (socat) and UNIX paths.
> 
> - Refactored test_ppc64_linux_migration to a private method
> _do_linux_migration(dst_uri, src_uri=None).
> - It is then called by three separate methods which exercise the
> TCP, UNIX and exec paths via the migrate_vms method from
> MigrationTest.
> ---
>  tests/functional/ppc64/test_pseries.py | 41 ++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
> index cb6d25dc81..19f31141b1 100755
> --- a/tests/functional/ppc64/test_pseries.py
> +++ b/tests/functional/ppc64/test_pseries.py
> @@ -8,8 +8,9 @@
>  # later.  See the COPYING file in the top-level directory.
>  
>  from qemu_test import Asset
> -from qemu_test import wait_for_console_pattern
> +from qemu_test import wait_for_console_pattern, which
>  from migration import MigrationTest
> +from qemu_test.ports import Ports
>  
>  class PseriesMachine(MigrationTest):
>  
> @@ -88,12 +89,20 @@ def test_ppc64_linux_big_boot(self):
>          wait_for_console_pattern(self, console_pattern, self.panic_message)
>          wait_for_console_pattern(self, self.good_message, self.panic_message)
>  
> -    def test_ppc64_linux_migration(self):
> +    def _do_linux_migration(self, dst_uri, src_uri=None):
> +        """
> +        Boot a pseries kernel on a source VM, wait until Linux is up, then
> +        migrate to a destination VM over the given URI(s) and verify the boot
> +        continues on the destination.
> +        """
>          self.set_machine('pseries')
>  
>          kernel_path = self.ASSET_KERNEL.fetch()
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>  
> +        if src_uri is None:
> +            src_uri = dst_uri

The default behavior of src_uri=None is non-obvious from the docstring.  Could
you mention that it defaults to dst_uri, and that callers using transports with
different source and destination URIs (such as the exec: case below) need to
provide src_uri explicitly?

> +
>          dest_vm = self.get_vm(name="dest-qemu")
>          dest_vm.add_args('-incoming', 'defer')
>          dest_vm.add_args('-smp', '4')
> @@ -111,16 +120,38 @@ def test_ppc64_linux_migration(self):
>          source_vm.set_console()
>          source_vm.launch()
>  
> -        # ensure the boot has reached Linux
> +        # ensure the boot has reached Linux before migrating
>          console_pattern = 'smp: Brought up 1 node, 4 CPUs'
>          wait_for_console_pattern(self, console_pattern, self.panic_message,
>                                   vm=source_vm)
>  
> -        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
> +        self.migrate_vms(dst_uri, src_uri, dest_vm, source_vm)
>  
> -        # ensure the boot proceeds after migration
> +        # ensure the boot continues on the destination after migration
>          wait_for_console_pattern(self, self.good_message, self.panic_message,
>                                   vm=dest_vm)
>  
> +    def test_ppc64_linux_migration(self):
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            self._do_linux_migration('tcp:localhost:%u' % port)
> +
> +    def test_ppc64_linux_migration_unix(self):
> +        self._do_linux_migration(
> +            'unix:%s/migration.sock' % self.socket_dir().name)
> +
> +    def test_ppc64_linux_migration_exec(self):
> +        if not which('socat'):
> +            self.skipTest('socat is not available')
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            self._do_linux_migration(
> +                'exec:socat TCP-LISTEN:%u -' % port,
> +                'exec:socat - TCP:localhost:%u,forever' % port)

I share Thomas's concern about CI cost.  With this patch, Linux is fully booted
three times — once per transport variant — which significantly increases the
wall-clock time of the pseries migration test slot.

The UNIX and exec transport paths are already covered on ppc64 in
tests/functional/ppc64/test_migration.py, though against mac99 rather than
pseries.  If the intent is specifically to validate these transports on the
pseries machine, that is a reasonable goal — but does it require a full Linux
boot?  The transport layer is independent of what the guest is running.  A
firmware-only pseries migration (as was done in v1) would cover the
pseries-specific migration path with substantially lower CI cost.

Please clarify in the commit message why a full Linux boot is needed here, or
consider using a firmware-only guest for the two new tests.

Thanks,
Amit

