Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDB5C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxwX-0002hN-N4; Mon, 21 Jul 2025 17:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvY-0001cA-B9
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1udxvT-0002lH-MV
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:20:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIfxnC012849
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4nwohGI0bwQaJgiNcSl4LKBBMspKPtG3MPh
 cY/MxFzY=; b=GlgnLpCbZtbpynYgpc5fQcGFo8lFOBwkgVpR9+gt5mGs7HCedHK
 2/JQ94xdJd0rBuOuRLEZPxNPhulR2CTdyMOfZ7ZmDbuy6Og/vUbsONiinz1C8m2K
 Dcx0JooMPIuJ5BHR051/ui6P8IggUHjL9z08TweAo/+a8amF0Gnsjdepq0i0Ug/v
 p6vaLDSa1r7zndjCgieTjXtDezJUE6i0eyPYon8pGZRiXsdV/SNhUMcUg+W8ZBI2
 PoWiDdcdDLDvd4WRzMpxVZq4DQHfIcrLX4oGxkdToiDffKkd5TpsViHgKpSgXgui
 +uhtKebb1RLI1ZNW+CKqqRmu/433OdQ/Ikw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3ej0v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:19:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-74913a4f606so3403076b3a.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 14:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753132795; x=1753737595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nwohGI0bwQaJgiNcSl4LKBBMspKPtG3MPhcY/MxFzY=;
 b=cf9Nn0Tvx/rsuOBqEs84FrgyDEyDCRppHQ8B9gJEgDXUUuZf1DHbh3+CCEPORVvcHU
 S0DmRv3qX2QTXw4gGB6PNNNNwpuVnJ6DXhqF1ex+ygx9R3HKdVKWtH79XlAfyHC4V4NG
 +HMs8Vh2eEHeJLqEBVuxIJ87I/HgMK9M/hVeNMi1Izt2acFcyNjLrJlWJEtznHxSH9jU
 QDYHZznyxA0rCpWvz/b4HYI3whivolpf78GVDyWJsvakoGT/CTwTBYuoanr1DU8vZIBL
 DfaKQVXmZMdsB2364RxMFk1RUsOz5E9zBhvsanmPWrBeb/DjgnGxLanhyOIlSlbrizXf
 0yxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRvyf66txQdYCrFZewTNRqb9nEyZHE44jp8hAncmfHFf4wVwao7HPgplizIJgFBm27VmzmFi3BfwJI@nongnu.org
X-Gm-Message-State: AOJu0YzykehTiTFWXagQeOpIVgeIpljdox5gkQb7biplRd2J9a6IXuk/
 oh1L8aDls/SguEu9c/HesIM5Psq/AfBiSnctebeU609ANRrveUeCkMnqXQUAdm2CpfDdRSNo8Sg
 6Lz901F7LC0ARaMHbDnOPWJ6rtztoT07QqsEoWmBMH/IwmI8OM/5L5+mKWQ==
X-Gm-Gg: ASbGnctbhwaYa0grwqhRO0zL48ux/CaOlyIfbTKGtKbXxhYJlClg8uwx3lGaTn0963e
 Q1eYIwcfwTmWY2xIqVsPj0+IvbKAHYi7haKYf7gkiaIwOoNwZSttDsZYgLYqPvbTcGfzMqE7CO+
 mVPU49j8xjBFYe7oniVk433Yfe++c2Zdcld5CVS7Xw7d8b99fovvEKp1fJ9+NCDG7sRYjDNAbWS
 EsNa9UpL5jLCcyVHdPeT+wI0bZdtt+O/RPoznmSG3K0/YNGE8k3ZBJPUKoqC074/olM6FhjYqVC
 cCFow5JsU4eo8Cg4fLM/OBSZlFJ0qvddIHHN6SHqmHhP4uC6+dVqmyju3AYdt7/FagKYSQsY++p
 n4hqI6xT2Z+bNpQQ=
X-Received: by 2002:a05:6a00:3c88:b0:74b:f639:33a6 with SMTP id
 d2e1a72fcca58-75722773326mr30197162b3a.2.1753132794937; 
 Mon, 21 Jul 2025 14:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbOdC9wSdvoGalNiiSUH0TfzJLawUb9SXFfhmINt8Arm2oMckTBCU6ZFNfKeUoVe421Y3Hdg==
X-Received: by 2002:a05:6a00:3c88:b0:74b:f639:33a6 with SMTP id
 d2e1a72fcca58-75722773326mr30197139b3a.2.1753132794407; 
 Mon, 21 Jul 2025 14:19:54 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc680absm6338808b3a.144.2025.07.21.14.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 14:19:53 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: vacha.bhavsar@oss.qualcomm.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 0/2] target/arm: Fix big-endian handling for NEON and SVE gdb
 remote debugging
Date: Mon, 21 Jul 2025 21:19:50 +0000
Message-Id: <20250721211952.2239714-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: D4YAsW4FBytJuMo8GrjvlMGORKpfjUIf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MCBTYWx0ZWRfXyliJASWFq4pl
 92Ir3jA3qAMSCgPl09IkpMbXK1fSxIbbtKTMvAp0CgPLXTyIO/o037IeplmnCfncnyFoBPMxD2Q
 HZbnEYULBRwXTLNwr+pveqUE/ANQnF6PmbCxOQbHe5XKoKACfgEUYvcdMaLOTbW5ycSWx1sc6Px
 AJjzj7jDB6c3j4ot7UTnD3/hTzfgcKmV0ogMYPPZVwSSfnvDsw+UoBuPSuh3szlDvL3ZQxE2Ds9
 2ZjbP//IvgP7aTgNy5GbxyLmOsBnASc/jhcQ102mxqCKLGGMfBQxguY9MGTDQOKeR8PQWISyRXP
 EZ3hGZ0kJvqk5yCB8aaDnccze4NDles7t5KgBZZK0twqjiaFLAtERJHWFcTN3sAFPxCSCa3VRri
 JQOo82Y2+pAJ3Gt4kEqLI2gfdd/izYbNNFlDhWaVhvMHtniYDv6pfKFvkpGZSHcMGKZFth6h
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687eaefc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=Wb1JkmetP80A:10 a=u4tEpLqHghJ1O5z5lBIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: D4YAsW4FBytJuMo8GrjvlMGORKpfjUIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=772 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210190
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Upon examining the current implementation for getting/setting SIMD
and SVE registers via remote GDB, there is a concern about mixed
endian support. This patch series aims to address this concern and
allow getting and setting the values of NEON and SVE registers via
remote GDB regardless of the target endianness.

Consider the following snippet from a GDB session in which a SIMD
register's value is set via remote GDB where the QEMU host is little
endian and the target is big endian:

(gdb) p/x $v0
$1 = {d = {f = {0x0, 0x0}, u = {0x0, 0x0}, s = {0x0, 0x0}}, s = {f =
{0x0, 0x0, 0x0, 0x0}, u = {0x0, 0x0, 0x0, 0x0}, s = {0x0, 0x0,
0x0, 0x0}}, h = {bf = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0}, f = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, u = {
         0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, s = {0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0}}, b = {u = {0x0 <repeats 16 times>},
s = {0x0 <repeats 16 times>}}, q = {u = {0x0}, s = {0x0}}}
(gdb) set $v0.d.u[0] = 0x010203
(gdb) p/x $v0
$2 = {d = {f = {0x302010000000000, 0x0}, u = {0x302010000000000, 0x0},
s = {0x302010000000000, 0x0}}, s = {f = {0x3020100, 0x0, 0x0,
0x0}, u = {0x3020100, 0x0, 0x0, 0x0}, s = {0x3020100, 0x0, 0x0,
0x0}}, h = {bf = {0x302, 0x100, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
f = {0x302, 0x100, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, u = {0x302,
0x100, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, s = {0x302, 0x100, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0}}, b = {u = {0x3, 0x2, 0x1, 0x0
<repeats 13 times>}, s = {0x3, 0x2, 0x1, 0x0 <repeats 13 times>}},
q = {u = {0x3020100000000000000000000000000}, s = {
      0x3020100000000000000000000000000}}}

The above snippet exemplifies an issue with how the SIMD register value
is set when the target endianness differs from the host endianness. A
similar issue is evident when setting SVE registers, as is shown by the
snippet below where the QEMU host is little endian and the target is big
endian:

(gdb) p/x $z0
$1 = {q = {u = {0x0 <repeats 16 times>}, s = {0x0 <repeats 16 times>}},
d = {f = {0x0 <repeats 32 times>}, u = {0x0 <repeats 32 times>},
s = {0x0 <repeats 32 times>}}, s = {f = {0x0 <repeats 64 times>},
u = {0x0 <repeats 64 times>}, s = {0x0 <repeats 64 times>}},
h = {f = {0x0 <repeats 128 times>}, u = {0x0 <repeats 128 times>},
s = {0x0 <repeats 128 times>}}, b = {u = {0x0 <repeats 256 times>},
s = {0x0 <repeats 256 times>}}}
(gdb) set $z0.q.u[0] = 0x010203
(gdb) p/x $z0
$2 = {q = {u = {0x302010000000000, 0x0 <repeats 15 times>}, s =
{0x302010000000000, 0x0 <repeats 15 times>}}, d = {f = {0x0,
0x302010000000000, 0x0 <repeats 30 times>}, u = {0x0, 0x302010000000000,
0x0 <repeats 30 times>}, s = {0x0, 0x302010000000000,
0x0 <repeats 30 times>}}, s = {f = {0x0, 0x0, 0x3020100, 0x0
<repeats 61 times>}, u = {0x0, 0x0, 0x3020100, 0x0 <repeats 61 times>},
s = {0x0, 0x0, 0x3020100, 0x0 <repeats 61 times>}}, h = {f = {0x0, 0x0,
0x0, 0x0, 0x302, 0x100, 0x0 <repeats 122 times>}, u = {0x0, 0x0, 0x0,
      0x0, 0x302, 0x100, 0x0 <repeats 122 times>}, s = {0x0, 0x0, 0x0, 0x0,
0x302, 0x100, 0x0 <repeats 122 times>}}, b = {u = {0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x3, 0x2, 0x1, 0x0 <repeats 245 times>}, s = {0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x2, 0x1, 0x0 <repeats 245 times>
}}}

Note, in the case of SVE, this issue is also present when the host
and target are both little endian. Consider the GDB remote session snippet below
showcasing this:

(gdb) p/x $z0
$6 = {q = {u = {0x0 <repeats 16 times>}, s = {0x0 <repeats 16 times>}}, d =
{f = {0x0 <repeats 32 times>}, u = {0x0 <repeats 32 times>}, s = {
      0x0 <repeats 32 times>}}, s = {f = {0x0 <repeats 64 times>}, u = {
      0x0 <repeats 64 times>}, s = {0x0 <repeats 64 times>}}, h = {f = {
      0x0 <repeats 128 times>}, u = {0x0 <repeats 128 times>}, s = {
      0x0 <repeats 128 times>}}, b = {u = {0x0 <repeats 256 times>}, s = {
      0x0 <repeats 256 times>}}}
(gdb) set $z0.q.u[0] = 0x010203
(gdb) p/x $z0
$7 = {q = {u = {0x102030000000000000000, 0x0 <repeats 15 times>}, s = {
      0x102030000000000000000, 0x0 <repeats 15 times>}}, d = {f = {0x0,
0x10203,
      0x0 <repeats 30 times>}, u = {0x0, 0x10203, 0x0 <repeats 30 times>},
s = {0x0,
      0x10203, 0x0 <repeats 30 times>}}, s = {f = {0x0, 0x0, 0x10203,
      0x0 <repeats 61 times>}, u = {0x0, 0x0, 0x10203, 0x0
<repeats 61 times>}, s = {0x0, 0x0, 0x10203, 0x0 <repeats 61 times>}},
h = {f = {0x0, 0x0, 0x0, 0x0, 0x203, 0x1, 0x0 <repeats 122 times>},
u = {0x0, 0x0, 0x0, 0x0, 0x203, 0x1, 0x0 <repeats 122 times>},
s = {0x0, 0x0, 0x0, 0x0, 0x203, 0x1, 0x0 <repeats 122 times>}},
b = {u = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x2, 0x1,
0x0 <repeats 245 times>}, s = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x3, 0x2, 0x1, 0x0 <repeats 245 times>}}}

In all scenarios, the value returning on getting the register after setting it
to 0x010203 is not preserved in appropriate byte order and hence does not
print 0x010203 as expected.

The current implementation for the SIMD functionality for getting and setting
registers via the gdbstub is implemented as follows:

aarch64_gdb_set_fpu_reg:
<omitted code>
uint64_t *q = aa64_vfp_qreg(env, reg);
q[0] = ldq_le_p(buf);
q[1] = ldq_le_p(buf + 8);
return 16;
<omitted code>

The following code is a suggested fix for the current implementation that
should allow for mixed endian support for getting/setting SIMD registers
via the remote GDB protocol.

aarch64_gdb_set_fpu_reg:
<omitted code>
// case 0...31
uint64_t *q = aa64_vfp_qreg(env, reg);
if (target_big_endian()){
	q[1] = ldq_p(buf);
        q[0] = ldq_p(buf + 8);
}
else{
	q[0] = ldq_p(buf);
        q[1] = ldq_p(buf + 8);
}
return 16;
<omitted code>

This use of ldq_p rather than ldq_le_p (which the current implementation
uses) to load bytes into host endian struct is inspired by the current
implementation for getting/setting general purpose registers via remote
GDB (which works appropriately regardless of target endianness), as well
as the current implementation for getting/setting gprs via GDB with ppc
as a target (refer to ppc_cpu_gdb_write_register() for example). Note the
the order of setting q[0] and q[1] is suggested to be swapped for big
endian targets to ensure that q[1] always holds the most significant half
and q[0] always holds the least significant half (refer to the comment
in target/arm/cpu.h, line 155).

For SVE, the current implementation is as follows for the zregs:

aarch64_gdb_set_sve_reg:
<omitted code>
// case 0...31
int vq, len = 0;
uint64_t *p = (uint64_t *) buf;
for (vq = 0; vq < cpu->sve_max_vq; vq++) {
env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
        env->vfp.zregs[reg].d[vq * 2] = *p++;
        len += 16;
}
return len;

The suggestion here is similar to the one above for SIMD, that ldq_p
should be used rather than simple pointer dereferencing. This suggestion
aims to allow the QEMU gdbstub to support getting/setting register values
correctly regardless of the target endianness. This suggestion aims to
yield results such as the following from a remote GDB session, regardless
of target endianness:

(gdb) p/x $z0
$1 = {q = {u = {0x0 <repeats 16 times>}, s = {0x0 <repeats 16 times>}},
d = {f = {0x0 <repeats 32 times>}, u = {0x0 <repeats 32 times>},
s = {0x0 <repeats 32 times>}}, s = {f = {0x0 <repeats 64 times>},
u = {0x0 <repeats 64 times>}, s = {0x0 <repeats 64 times>}}, h = {f = {
      0x0 <repeats 128 times>}, u = {0x0 <repeats 128 times>}, s = {
      0x0 <repeats 128 times>}}, b = {u = {0x0 <repeats 256 times>}, s = {
      0x0 <repeats 256 times>}}}
(gdb) set $z0.q.u[0] = 0x010203
(gdb) p/x $z0
$2 = {q = {u = {0x10203, 0x0 <repeats 15 times>}, s = {0x10203,
      0x0 <repeats 15 times>}}, d = {f = {0x10203, 0x0
<repeats 31 times>},u = {0x10203, 0x0 <repeats 31 times>},
s = {0x10203, 0x0 <repeats 31 times>}}, s = {f = {0x10203,
0x0 <repeats 63 times>}, u = {0x10203, 0x0 <repeats 63 times>},
s = {0x10203, 0x0 <repeats 63 times>}}, h = {f = {0x203, 0x1,
0x0 <repeats 126 times>}, u = {0x203, 0x1, 0x0 <repeats 126 times>},
s = {0x203, 0x1, 0x0 <repeats 126 times>}}, b = {u = {0x3, 0x2, 0x1,
0x0 <repeats 253 times>}, s = {0x3, 0x2, 0x1, 0x0 <repeats 253 times>}}}

The first patch will implement this change for NEON registers,
and the second patch will do so for SVE registers.

Vacha Bhavsar (2):
  This patch adds big endian support for NEON GDB remote debugging. It
    replaces the use of ldq_le_p() with the use of ldq_p() as explained
    in the first part of this patch series. Additionally, the order in
    which the buffer content is loaded into the CPU struct is switched
    depending on target endianness to ensure the most significant bits
    are always in second element.
  This patch adds big endian support for SVE GDB remote debugging. It
    replaces the use of pointer dereferencing with the use of ldq_p() as
    explained in the first part of this patch series. Additionally, the
    order in which the buffer content is loaded into the CPU struct is
    switched depending on target endianness to ensure the most
    significant bits are always in second element.

 target/arm/gdbstub64.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.34.1


