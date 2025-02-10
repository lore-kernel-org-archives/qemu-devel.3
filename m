Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCCFC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaZW-00055c-Uu; Mon, 10 Feb 2025 15:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1thaZV-00054e-0k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:40:01 -0500
Received: from rn-mx02.apple.com ([17.132.108.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1thaZT-00036k-El
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:40:00 -0500
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by mr55p01nt-mxp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SRH291G9IQJCO20@mr55p01nt-mxp02.apple.com> for
 qemu-devel@nongnu.org; Mon, 10 Feb 2025 20:39:55 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_11,2025-02-10_01,2024-11-22_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=0sascirrTTL3Ba1QHLoaQ9g4Z4jZkMlO9virPyDuR3w=;
 b=jnmbJabHuJ9Y4ZKjkwXPvUvnsBv+JoQfewBSBLW9d7nXuOy3wgEYFar35MKhAZoyXVPz
 CwGw0sIe3GWTjTrFuunI91c9+ayOogFmQeaVKWAy+WNYs3olcVf6iUd7HWzU2pyPP4Zp
 EihCPGLHFh3Z09VTYchfuZZnM8kjRY8B6H36Cap9UnABh83X/PBSh4hNSlRfgm7VypvJ
 8OKCAAuyNBuABdR+Ub7aif+lC8cjpjnldEYHlNx41hRPb1/EwdL+cpNwMkmiIMBUPtZH
 r0r+FsoPzLSms1DUHFg+rfFQWsiCL5idOVJJaO/YnAd/xGJFFhrifYhATcFlUWou0ao8 LA==
Received: from mr55p01nt-mmpp02.apple.com
 (mr55p01nt-mmpp02.apple.com [10.170.185.213])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SRH00N1CIQJI6L0@rn-mailsvcp-mta-lapp02.rno.apple.com>; 
 Mon, 10 Feb 2025 12:39:55 -0800 (PST)
Received: from process_milters-daemon.mr55p01nt-mmpp02.apple.com by
 mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SRH0X400INC0100@mr55p01nt-mmpp02.apple.com>; Mon,
 10 Feb 2025 20:39:55 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-Va-E-CD: 2325b25e1853304713f33c2dc3bf5831
X-Va-R-CD: f2c730f0a964009da4023b008f6c4c11
X-Va-ID: ff56baa5-7b1a-49e7-b333-fd79c3c0d7b6
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 9be860c946f6cbc0801dd392535b1c06
X-V-E-CD: 2325b25e1853304713f33c2dc3bf5831
X-V-R-CD: f2c730f0a964009da4023b008f6c4c11
X-V-ID: 9ff289cb-53d6-4fec-9088-17f1f35cfe69
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_11,2025-02-10_01,2024-11-22_01
Received: from smtpclient.apple (unknown [17.243.208.254])
 by mr55p01nt-mmpp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SRH0W6CVIQH2C00@mr55p01nt-mmpp02.apple.com>; Mon,
 10 Feb 2025 20:39:54 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3815.100.3\))
Subject: Re: [PATCH v2 3/3] hvf: arm: Implement and use
 hvf_get_physical_address_range
From: Danny Canter <danny_canter@apple.com>
In-reply-to: <CAFEAcA-Npf_9gV=LP2pmpgQ+dbqxQnJk1ubrtAhUc3nVbM-s6Q@mail.gmail.com>
Date: Mon, 10 Feb 2025 12:39:43 -0800
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>, dirty@apple.com,
 rbolshakov@ddn.com, agraf@csgraf.de, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, zhao1.liu@intel.com
Content-transfer-encoding: quoted-printable
Message-id: <CF400E00-3635-4556-B19C-91A50A41CD53@apple.com>
References: <20240828111552.93482-1-danny_canter@apple.com>
 <20240828111552.93482-4-danny_canter@apple.com>
 <e67f8106-f741-4e81-a291-db06bfbedd7c@linaro.org>
 <1CE8C01E-6930-4DFA-8C96-CACCFEBD24AE@apple.com>
 <CAFEAcA-Npf_9gV=LP2pmpgQ+dbqxQnJk1ubrtAhUc3nVbM-s6Q@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3815.100.3)
Received-SPF: pass client-ip=17.132.108.1; envelope-from=danny_canter@apple.com;
 helo=rn-mx02.apple.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

No worries, will get a machine on 15.2 at least as it seems both reports =
are on that or higher. I=E2=80=99ll likely have time mid to late week to =
debug this. Thanks!

-Danny =20

> On Feb 10, 2025, at 10:24=E2=80=AFAM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 10 Feb 2025 at 18:20, Danny Canter <danny_canter@apple.com> =
wrote:
>>=20
>> Will do. I=E2=80=99ll reach out if I need extra info. The issue =
appears to be closed though, was this fixed/no-repro already though?
>=20
> Whoops, no, that must have been a mis-click on my part.
>=20
> While you're looking at address-space related bugs,
> https://gitlab.com/qemu-project/qemu/-/issues/2713
> is another recent one -- user reports that QEMU says they're
> limited to 32 bits even though their mac/macos has a 40-bit
> IVA space.
>=20
> thanks
> -- PMM


