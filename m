Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B71DC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weSts-000511-Ux; Tue, 30 Jun 2026 03:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weStq-00050l-Tn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:28:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1weStp-0008Fa-6n
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 03:28:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CIRw1073739
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 07:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kaNn1NqCXseJh7V2UupfoDA4Kfpoog+fUBJG6GKdqqc=; b=GnLHGmOZaB3Z7v70
 voDEJ8p4It6kFE43QXqwdcwGzQNxKhzk/njoSAK7j3I6rr0c/vHx8/7E+gthVHnV
 720FMbkGtBpGjdXWUHm42n1WiZ4SZuVVJb46UpstPB+c6ow3cT0dS/g/y8cXMAHY
 biYTdADpbK5luCPV6WaJW6hCn6TCTK9jZFksz9h3RuVI/+dUZE1DpZ3ujStjQgPc
 d55qfXXbjira+rVOT+9v0z9YebGdn48cM+aLD4rEYpwCRBicaGLmFOcJDFgYBgEq
 s1d9rmvkgnclkJtXao5oFmpmyxILF8Lwf2WxZiPDnLoApb9S4dneLbgtCz4I35LO
 xShiDg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k25dc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 07:28:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c62861b3bso13189743eec.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782804531; x=1783409331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kaNn1NqCXseJh7V2UupfoDA4Kfpoog+fUBJG6GKdqqc=;
 b=KBvQvhfOTZGG8knXo+MAogSVFKZplSQBO6CeIDFJx5+6VkXGaNOJvwJXVfxglZhd81
 37dFXmV9Wqj1lmEdQVmzJMGvRT9paMahIDTorOdNWTZLgN8yys3tZudrW/5Bc+jSTvFo
 Fp3oBHwUVHJxOaVNKYkH8F5OX/wiTONnjFJk0IpU4Omf/05xt2LPkB+wmzNvAo0RWtnm
 gzUHh89m033DiZZC0GyBXIKNtL/kcenOh0A43GhrxZdqbrX+hOw8kAF25CWGXSJltdiO
 umjzzM6PNtDvFd/lj7sTcXAJE5QyVQ7LQw7H63w+SMNBEjQ2fM4kVvNiH9RYCmJokq3u
 30HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782804531; x=1783409331;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kaNn1NqCXseJh7V2UupfoDA4Kfpoog+fUBJG6GKdqqc=;
 b=r0gOp/kIO7rI8vbJoya8hLTYK6bQTUB9fBukdyQB0rcGIcT0HdXqrsPrvCkJLvocqQ
 i+RsBgCUkJ9Oct2H4OVP/8WnpDJaMkL2OjmMxiXeHuZvLflKiW+WK1cQaKC85fV9+wrX
 /JXG/HgW0yRFa5ZeFIGDPAm9B4JxheUwRhH0Rhcms9+b5mvr5INB2tfZkSvJQt83LeQf
 MoDZhdRd6SL3fnRbOgth5ig93Zrepfx1uuQ62CKVe146p1wIYP51kZleTRigPEKNEnoN
 uGrSEyM1+mKIUn5nIPw/B0B1mATbcXqOrV0UsTJaJf3pk1LbfgJH+GxM+ekTG/XeqjEx
 xsTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrmh8P87IWgdMAnvQPSPkfMrtCj7hF7uBkkHN0pzrShmYEjcRCqm+403vhADQ8MIT15p1gTTH/SsPK+@nongnu.org
X-Gm-Message-State: AOJu0YxtGiV9hrqLOilaK1jqRMbwXa92Uf5nRVaLeNLV6Cxmyo5cNemK
 TGgYPEMbphIzTxIA9Z4FoB1upkH3dEX1w8gMNeN+k5XfnfhCGF3EjquXV+kQ31NinaVwN1x4Ktg
 cNBmGRKjT5nqi1Iqp/eshsxCpmv49ahZRdJMzxm0batxk71p0rMsUwxxFxg==
X-Gm-Gg: AfdE7cngcjmacaaCiYGleTKeCkhldbJ3FfXQSO4EhA/6Jyl/VCvq8o5cBDi9TooKK6M
 HciWLjiuy0Mww1xANGSBYl2LcwdstFJZ7dFHjtkazvNDAdZ8+RXaBBqDk8SKI/OX9r2Kf6JWR3P
 Q048WXYlx/DIsuD1peEmw8cOtvbopbl9MPvyvIGzjHEypO1G1pp/teJVwwi3C/S5pDWQaZaiPHD
 sDsaw4fzBbUCIT8z0sVYZMgsjHIe5WqSNUqruqiL2mIQpSBRdiyJGcT+5rXGpmPE4qiMZ0c8nM1
 VhysenHT2ajv2H9WT/2mme8fm6udgtd6UVytsPP44tht2CXigHVH7PVsOD1aB6OQGklihNaUJOt
 PHB7oVnk5lZfSBzNwPCfDl1N0E+TqYlsifUSPCtnK4FfzAovaVvhLXQWYX1k6Ph5p9Sd+5oIWw9
 wJ2ew=
X-Received: by 2002:a05:7300:768c:b0:304:997c:d43b with SMTP id
 5a478bee46e88-30ee13a2070mr2090113eec.34.1782804530764; 
 Tue, 30 Jun 2026 00:28:50 -0700 (PDT)
X-Received: by 2002:a05:7300:768c:b0:304:997c:d43b with SMTP id
 5a478bee46e88-30ee13a2070mr2090080eec.34.1782804530117; 
 Tue, 30 Jun 2026 00:28:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2f5e4d1sm4835069eec.6.2026.06.30.00.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 00:28:49 -0700 (PDT)
Message-ID: <53159abf-ae84-465a-ac70-8ad71fa6c045@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 00:28:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] 9p queue 2026-06-29
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA2NCBTYWx0ZWRfX+dEd7cu1KWv/
 UlGq+gOt+H8p/HpPE6Opj66G8bElBwd31atrsK8kRagitu9woH8QsD9tTRnySmaQ63gaE8qZ8L9
 +b6XVjdXyVPPiBcoSB1WXjDUEmSeCFg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA2NCBTYWx0ZWRfX7uGaMiyxIFrN
 3cdv7UGv6L7Yk155VFDfimaEDjqR1NbKmrbikk/89nKgML1clRZD30yFkHY2zwwqZaW2Ovd2sPs
 u0QyltFrX1yZ3Kwr5MTr0H0Iw4ZkiWiyzhlyuUbG8AQwdsug04WLQwMk/eoXD6m3jckxHOsjcIW
 yZTyWS8DYpsfgQbq9Hhh3/VQ+5CsHT1qk1yqy/zZZtno90HYcRsetTfCT3KvhKzKZYzOzawdMOC
 2TYsgaM+BCmu1EzdYKB72Z+Y1pjW1Iby0zSiVLNP2bES88+fXiDMJGf9tZqDif4gUZAIQv0WhCs
 EE1iNd1+ppvmDqtsqDm7P8V4ZACdQYq9jgUV0tTfAflRkd1ET1L1xnvyD/U1xt98ztjWExmwcqp
 GFW9/81ymjflmJTLa//NkC9FSN3zu9uh3W9JQxOYg6tOm/foYMapy31gweaAW0XSwhrSDqcCZvm
 40nDkwJC/jxyLaenwVA==
X-Proofpoint-ORIG-GUID: E5awjw2OmVabHKRjOOvMPRlGn0s0tPsu
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a437033 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=Jt8mAcKv_4fBCqvF0XoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: E5awjw2OmVabHKRjOOvMPRlGn0s0tPsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Christian,

On 6/29/2026 6:28 AM, Christian Schoenebeck wrote:
> The following changes since commit 20553466cc47af6a8c95f665b601fce3c852e503:
> 
>   Merge tag 'pbouvier/pr/docs-20260626' of https://gitlab.com/p-b-o/qemu into staging (2026-06-27 23:28:35 -0400)
> 
> are available in the Git repository at:
> 
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260629
> 
> for you to fetch changes up to 75893c058b21d87d1ec66bbd4e8bf84e1fd616d1:
> 
>   hw/9pfs/local: harden local_fid_fd() on FID types (2026-06-29 15:10:32 +0200)
> 
> ----------------------------------------------------------------
> 9pfs changes:
> 
> - Fix DoS via Treaddir (CVE-2026-9238).
> 
> - Add xattr FID limit (CVE-2026-8348).
> 
> - Fix union V9fsFidOpenState type confusion.
> 
> ----------------------------------------------------------------
> Christian Schoenebeck (23):
>       hw/9pfs: add msize_limit transport callback
>       9pfs/virtio: implement msize_limit callback
>       9pfs/xen: implement msize_limit callback
>       hw/9pfs: cap negotiated msize to transport limit
>       hw/9pfs: add response_buffer_size transport callback
>       9pfs/virtio: implement response_buffer_size callback
>       9pfs/xen: implement response_buffer_size callback
>       hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
>       hw/9pfs: add xattr FID limit to prevent memory exhaustion
>       hw/9pfs: add max_xattr option
>       qemu-options: document 9pfs max_xattr option
>       tests/9p: add Tread / Rread test client functions
>       tests/9p: add Tclunk / Rclunk test client functions
>       tests/9p: add Txattrcreate / Rxattrcreate test client functions
>       hw/9pfs: enable xattr (mockup) support for synth fs driver
>       hw/9pfs: add xattr count query interface to fs synth driver
>       tests/9p: increase P9_MAX_SIZE for test client
>       tests/9p: add virtio_9p_add_synth_driver_args() test client function
>       tests/9p: add 3 xattr FID limit test cases (synth fs driver)
>       tests/9p: add 3 xattr FID limit test cases (local fs driver)
>       hw/9pfs: fix invalid union access by v9fs_co_fsync()
>       hw/9pfs: fix invalid union access by v9fs_co_fstat()
>       hw/9pfs/local: harden local_fid_fd() on FID types
> 
>  fsdev/file-op-9p.h                    |  11 ++
>  fsdev/qemu-fsdev-opts.c               |   6 +
>  fsdev/qemu-fsdev.c                    |   2 +-
>  hw/9pfs/9p-local.c                    |  14 +-
>  hw/9pfs/9p-synth.c                    |  51 ++++++-
>  hw/9pfs/9p.c                          | 113 ++++++++++++++-
>  hw/9pfs/9p.h                          |   2 +
>  hw/9pfs/virtio-9p-device.c            |  17 +++
>  hw/9pfs/xen-9p-backend.c              |  31 ++++
>  qemu-options.hx                       |  28 ++--
>  system/vl.c                           |   7 +-
>  tests/qtest/libqos/virtio-9p-client.c | 124 ++++++++++++++++
>  tests/qtest/libqos/virtio-9p-client.h |  88 +++++++++++-
>  tests/qtest/libqos/virtio-9p.c        |   6 +
>  tests/qtest/libqos/virtio-9p.h        |   6 +
>  tests/qtest/virtio-9p-test.c          | 262 +++++++++++++++++++++++++++++++++-
>  16 files changed, 746 insertions(+), 22 deletions(-)
> 

This series brought a test regression:
$ ./build/pyvenv/bin/meson test -C build \
--setup thorough --print-errorlogs \
qemu:qtest-aarch64/qos-test
...
ERROR:../tests/qtest/libqos/virtio-9p-client.c:280:v9fs_req_recv:
assertion failed (hdr.id == id): (7 == 121)

It seems to come test added in patch 19
"tests/9p: add 3 xattr FID limit test cases (synth fs driver)"
This test runs only with slow setup, so I suspect it never worked and
was never ran.

Could you take a look to fix or revert the concerned change?
You can add me in copy, I'll be happy to review and test it.

Thanks,
Pierrick

