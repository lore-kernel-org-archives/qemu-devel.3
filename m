Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D10606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SHfsdMlK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJIig-000885-4h; Tue, 20 Oct 2026 18:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJIic-00087M-0G; Tue, 20 Oct 2026 18:54:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1xJIiZ-0004aQ-QX; Tue, 20 Oct 2026 18:54:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KLEESl3557412; Tue, 20 Oct 2026 22:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GJqCbu
 fo1v8bB/Hl3cXamDzFwkf1uK+9+ewEpka7zYg=; b=SHfsdMlKvAS+Al7kwapemR
 UPfpv0OUelaL6kXQUrNn1oCaP/YQbw7rSFgVTffc1xMTOq7SCgwqdEb20t7+ymiZ
 PX7GnYKyR72xlQ5qMg1z4q8EExUYu0kB97d+yqUPnbrs7L/Fcx0TzCXm+ejVOUwT
 BThQPK8ZvzSF3yvI7XravMpb3tMF69+ovRUMAODmbH9MZnm2QeovIlqZknrarA3m
 /1qA2LZxR/VUw5BzFk3DlW3BdHQ9nbibZIjYt3/20AI+0IhMSisnzsLcK2tL/PcG
 j2J8F8Dc5a7NHGoQkkD8KPyc1cjKOE7UaxIMntXbR2l88MeB3BCrwJZbKjUVIk0A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a5t2h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 22:53:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KL4tHB883699; Tue, 20 Oct 2026 22:53:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss0c56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 22:53:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69KMrewZ50856422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Oct 2026 22:53:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4586720040;
 Tue, 20 Oct 2026 22:53:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D65F20043;
 Tue, 20 Oct 2026 22:53:39 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.149.137])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Oct 2026 22:53:39 +0000 (GMT)
Message-ID: <027d6109-bf20-4fe8-ac5f-73f12fa55bcf@linux.ibm.com>
Date: Wed, 21 Oct 2026 00:53:39 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/19] tests/functional: teach tuxrun about launching
 gdb tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Ani Sinha <anisinha@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-13-alex.bennee@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261019192704.3220373-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA5MCBTYWx0ZWRfX2OBBDRfD/+go
 jb1OyZEe/P8VUPpapOob4DH2Exk4mxzSBJSfpT6lU+ODEGWqxHoK5g/x/AlkbqA1oHZkESCphQd
 7gY9KPOkEnXTmYwY+QzfnCWMvN313Lk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA5MCBTYWx0ZWRfX8HBXzrxo0pPy
 j6T0W96O3oOALMl1vFDt/sj4Y2dd/KB+XJAzPlBzy7VDiM4BokaogUP2e5fYqSRenkBTqBSObRz
 pC87xQjUzfBQdDD4CyV6qDtLGFH7OA+zwfNNAnl4jgoeIda6j5VHg3d3qEri2Y02oHbnSS9ePd/
 yPD8dc/OJIB6bcvNplI+Q6uGyO7/AzcxArBqK13DKv2pekuQc7G9sVzSI5xG4nfH7U/y96yW1fj
 lBX3uOjFk2FFXNExzo5X06H6ZKLvy8QoFH2rhPZwGcPeYOJsgFmyS+o8cK7V5O2vE8NCOpMPQb+
 +m01hI3f3arcOLWURtFVOYSkdFSwTwnf5EqmwuVRua/98L189uMDJfYG66n7jvVdaDPuydsPRzF
 3J6GN6Om7OhE84AXK4+//hp7XBJ0849cinkiibc014mmN7yegiCmIDLv8ckKB46ZoxCwWb7erxk
 EhOVEfNx3aBxXZH/IPA==
X-Proofpoint-GUID: rKjBPW95V2RGjrerRArbgAaten4fGnV3
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad7f0f9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=Jv6o_MDdWyvUFkLk1GcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rKjBPW95V2RGjrerRArbgAaten4fGnV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 21:26, Alex Bennée wrote:
> This resurrects the hand run test script from d84842be6c5 (tests:
> remove test-gdbstub.py) and modernises it to use the shared test
> infrastructure for run-test.
> 
> We then tweak the common tuxrun code to over an alternative "launch

                                           offer?

> via gdbstub" helper which reuses the existing code but:
> 
>    - needs a vmlinux with symbols
>    - drops kaslr because it doesn't play nice with symbols
>    - extend qargs with stuff normally added by vm.launch
>    - passes kargs directly
>    - runs with the gdb run-test script
>    - log the run-test output to the console log
>    - makes --binary not mandatory
> 
> Message-ID: <20260930164649.433573-13-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - mention the nokaslr in the commit message
>    - add a comment about it to the shared kernel args
>    - drop unused failcount
>    - remove stale comment about hbreak
>    - always delete the watch point pass or fail
>    - fix unbalanced tuple in sh4's direct call of fetch_tuxrun_assets
>    - simplify the symbol to watchpoint logic
>    - drop the mandatory --binary
>    - make the command copy and paste friendly
> v2
>    - add self.vm._machine to qargs
>    - drop leading spaces in print () calls
>    - add register read tests
>    - use gdb.Breakpoint for hwbreak as for swbreak
>    - drop flaky symbol evaluation, verify hit_count instead
>    - explicit gdb.BP_BREAKPOINT for CatchBreakpoint
> ---
>   .../functional/gdb-scripts/kernel_gdb_test.py | 162 ++++++++++++++++++
>   tests/functional/qemu_test/tuxruntest.py      |  97 ++++++++++-
>   tests/functional/sh4/test_tuxrun.py           |   4 +-
>   tests/guest-debug/run-test.py                 |  14 +-
>   4 files changed, 261 insertions(+), 16 deletions(-)
>   create mode 100644 tests/functional/gdb-scripts/kernel_gdb_test.py

[...]

> @@ -132,10 +144,77 @@ def common_tuxrun(self,
>           special with the command line we can process most things using
>           the tag metadata.
>           """
> -        (kernel, disk, dtb) = self.fetch_tuxrun_assets(kernel_asset, rootfs_asset,
> -                                                       dtb_asset)
> +        (kernel, disk, dtb, _) = self.fetch_tuxrun_assets(kernel_asset,
> +                                                          rootfs_asset,
> +                                                          dtb_asset)
>   
>           self.prepare_run(accel, kernel, disk, drive, dtb, console_index)
>           self.vm.launch()
>           self.run_tuxtest_tests(haltmsg)
>           os.remove(disk)
> +
> +    def common_tuxrun_gdb(self,
> +                          kernel_asset,
> +                          vmlinux_asset,
> +                          rootfs_asset,
> +                          accel=None,
> +                          dtb_asset=None,
> +                          drive="virtio-blk-device",
> +                          haltmsg="reboot: System halted",

This argument seems to be unused.

> +                          console_index=0):
> +        """
> +        Common path for LKFT tests under gdb. Unlike the common_tuxrun
> +        function we need to launch with the gdb test script and deal
> +        with munging the arguments for that especially.
> +        """
> +        (kernel, disk, dtb, vmlinux) = self.fetch_tuxrun_assets(kernel_asset,
> +                                                                rootfs_asset,
> +                                                                dtb_asset,
> +                                                                vmlinux_asset)
> +
> +        gdb_path = os.getenv("QEMU_TEST_GDB")
> +        run_script = self.data_file('..', 'guest-debug','run-test.py')
> +        test_script = self.data_file('gdb-scripts', 'kernel_gdb_test.py')
> +
> +        # Instead of launching QEMU via the functional test machinery
> +        # we need to launch it with the gdb run script. We utilise the
> +        # existing prepare_run machinery to build the command line but
> +        # we pass the kernel args separately to avoid horrible string
> +        # escaping.
> +
> +        self.prepare_run(accel, kernel, disk, drive, dtb,
> +                         console_index, append = False)
> +
> +        # the functional test machinery adds more stuff for handling
> +        # console redirection which we need to do manually.
> +
> +        qargs = self.vm.args
> +        qargs.extend(["-display", "none", "-serial", "stdio"])
> +
> +        # and the machine type
> +        if self.vm._machine is not None:
> +            qargs.extend(["-machine", self.vm._machine])
> +
> +        cmd = [
> +            str(run_script),
> +            "--qemu", self.qemu_bin,
> +            "--qargs", " ".join(qargs),

I would use shlex.join() here, for symmetry with shlex.split() that
is used to handle this.

[...]

Anyhow:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


