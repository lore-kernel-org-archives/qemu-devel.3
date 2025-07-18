Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A657C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 19:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucqcD-0007bW-BF; Fri, 18 Jul 2025 15:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ucq8t-0003DE-SZ
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 14:49:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ucq8r-0002Sf-4s
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 14:49:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHUK4d008498
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 18:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=w/lQuxDCQBVsVTUQZbFlH47iI+AaFLrX6OO5Hx3g/V0=; b=pF
 s6Nrlj4VgCZoYwCVyUJreRa4sExMiJ7BswLJcrbMAE6eMViGdZRSW6d72tOhDwPq
 7e96OaGjDtJBGH4lHJX5GsCeSExOHequ86sKdmMNlJOjf1EocCKvG3T4m0FUxpgB
 ectkNiHggChctQdM02D4PXMkYVUlG0BHB4QukIX7RCRksMwevntrbmhKe1nPQQ7i
 YGf/fptAXHj1zoG05Zwih5WMZ1zS/F2Y8Enl5XPMpmo0G89CbhmziICSDT51HRpU
 zgjVOb4Cpj5bogwjBosjzzBf5wEzPP5tf2bVPxcSREX00ZmMKB9b/GJ/3P7BpBFi
 gGO4TjWPQeom8HybhZDg==
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbcn6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 18:49:05 +0000 (GMT)
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e8bcb21f1b8so3119814276.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 11:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752864544; x=1753469344;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/lQuxDCQBVsVTUQZbFlH47iI+AaFLrX6OO5Hx3g/V0=;
 b=KMdo2OG8Wt3PDJ8nX7EtZoSfAWVo7VcDFKh07a361GtnVsXeJnj8vK4U9vbokoVB4+
 eNSivtUIP/EEy+nNaRt3qaPA4dDOWNe/nBGQ0fL2oHiREqDwPaTi1yJBKrZ12+N/qvxs
 FePihLeid8TISI3tBQB25XpFNe3sxjvVO/cqNKEOLpf4a5BKVw79oFr1suDxbQTijdTH
 9hQUXGBpNq8ocRG+vb47GNS1BgSnMgPbU7ZjSmBWAcRujKCyC3hVN8yHztHtOL8whrro
 AfKYf7UfK0G4qHdRPzMaq4YmnT9VTLSt6QAbhbYTFWgENnRpNL/ySiLtRrZJv8c9lRWC
 AYsA==
X-Gm-Message-State: AOJu0YzMi0VWfhovC8tSVNQeySoFIZZh9wL0Up3SrOu25U+9hIasajIK
 E0egjSRz83+Lt5XfG0A2vK4SzclMQG4w4b3jrHzZTWsWGG9EgMTCgEATepSkvOC7XXZc2CbV7Zf
 UVEHjoOyyXPs3O2zlqq7t4ZjznBOfi14jjd98SzNXAay1+MM7GHgEhFLHZgi3H6cz/SPC8jKjTe
 xreinLCH9WixUN5oaO5Cjc+p90u8rJmVLZYwoHhK4UOb4=
X-Gm-Gg: ASbGncuowJtIKS5YSxwU+qAhyb/L2AwhnstaLNPhFMRt6F6hCoEwQcJI1EeXCDy6ZLq
 IzlSbp/j9STe7OhyPTMza6sIhZ8ldXJr27G7gaGroRPy2K7P6SUMDahT3EoQweKfFLMlhSU/BDe
 5WDr7Q7eM8sCTF5W7msRDk+g==
X-Received: by 2002:a05:6902:18ce:b0:e89:7280:bf98 with SMTP id
 3f1490d57ef6-e8c5fb98d12mr9564511276.48.1752864544056; 
 Fri, 18 Jul 2025 11:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOFFx4LFsQfEOAfWxcyy8arc3u3pjsA5YFYyfyYg9nNmfVFPxKK7rmqZe+zNNi5DNnX8va5q/BTuusCItFb4o=
X-Received: by 2002:a05:6902:18ce:b0:e89:7280:bf98 with SMTP id
 3f1490d57ef6-e8c5fb98d12mr9564479276.48.1752864543353; Fri, 18 Jul 2025
 11:49:03 -0700 (PDT)
MIME-Version: 1.0
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 14:48:51 -0400
X-Gm-Features: Ac12FXyM3n8dWEYA7jslaEkVqArEqxGjCS1Ojq_vsBZHcyfuGA8eFefFGtZHnYE
Message-ID: <CAEWVDmuS0RSwZiDGNZg4cT1jXp7Xfu97YZL7hDfTvha2TOgS1g@mail.gmail.com>
Subject: [RFC] target/arm: Concerns about mixed endian support for remote GDB
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000725057063a38948e"
X-Proofpoint-GUID: ax313kfruEb3simeGnpFEz4Z1IF6327L
X-Proofpoint-ORIG-GUID: ax313kfruEb3simeGnpFEz4Z1IF6327L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0OSBTYWx0ZWRfX1uGb0qWNowe4
 VehkGr9bP3LpfcPqtayBSREpwYVoJ0xbC/fX/DtEBLvHRCKaEknyM87eQ6XHOdyQRr4TWHbUZO1
 qbdGl4Y3dlRkI0DD8Mv8GYm1NYDlZoUEoFEGRV1V6MoZyc2qpbWWdJw2h78QL/YZ7vFSbOtuY64
 H/8VqStk2sitg9zVHDoq79hk1cyuxA6Rkv8BrMWc/PGYAeEdcGChjbwdZ0i1Po0VKBDaXEy2ZQp
 O3GPSkV3XS4Q+jxDqvp0TYEk3o/SEe0uV03/bFeSKVb8+slvD2Z1hvhlPhBrVeL2mJjvKHQNj0C
 99BPcKDlocpWag7k0qB9nADGEYC8XY+Ql5RXbxVLYqm2+RLuK/NRL6jkcBVEQecq6b1UCTzLzz/
 WODwLraOdAm/c773EovlqZkBLvP8ugYR4NnaTYdf5MkuQXVg8jc84M+WfxZeGA74HPq9zN5z
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a9721 cx=c_pps
 a=peiObFy/9J5zY6vzkL/ViA==:117 a=Wb1JkmetP80A:10 a=OtHITOApMHYOX6r9MroA:9
 a=QEXdDO2ut3YA:10 a=kjEkAWSLhUONxAS0VI4A:9 a=G_WUqgConza7r-74:21
 a=uSskPZdq7w8du69dlLff:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=810
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000725057063a38948e
Content-Type: text/plain; charset="UTF-8"

Upon examining the current implementation for getting/setting SIMD
and SVE registers via remote GDB, there is a concern about mixed
endian support.

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
and target are both little endian. Consider the GDB remote session snippet
below
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

In all scenarios, the value returning on getting the register after setting
it
to 0x010203 is not preserved in appropriate byte order and hence does not
print 0x010203 as expected.

The current implementation for the SIMD functionality for getting and
setting
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
        q[1] = ldq_p(buf);
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

--000000000000725057063a38948e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Upon examining the current implementation for getting/sett=
ing SIMD<br>and SVE registers via remote GDB, there is a concern about mixe=
d<br>endian support.<br><br>Consider the following snippet from a GDB sessi=
on in which a SIMD<br>register&#39;s value is set via remote GDB where the =
QEMU host is little<br>endian and the target is big endian:<br><br>(gdb) p/=
x $v0<br>$1 =3D {d =3D {f =3D {0x0, 0x0}, u =3D {0x0, 0x0}, s =3D {0x0, 0x0=
}}, s =3D {f =3D <br>	{0x0, 0x0, 0x0, 0x0}, u =3D {0x0, 0x0, 0x0, 0x0}, s =
=3D {0x0, 0x0,<br>	 0x0, 0x0}}, h =3D {bf =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0, <br>	 0x0}, f =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, u =3D {<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
}, s =3D {0x0, 0x0, 0x0,<br>	 0x0, 0x0, 0x0, 0x0, 0x0}}, b =3D {u =3D {0x0 =
&lt;repeats 16 times&gt;},<br>	s =3D {0x0 &lt;repeats 16 times&gt;}}, q =3D=
 {u =3D {0x0}, s =3D {0x0}}}<br>(gdb) set $v0.d.u[0] =3D 0x010203<br>(gdb) =
p/x $v0<br>$2 =3D {d =3D {f =3D {0x302010000000000, 0x0}, u =3D {0x30201000=
0000000, 0x0},<br>	s =3D {0x302010000000000, 0x0}}, s =3D {f =3D {0x3020100=
, 0x0, 0x0,<br>	0x0}, u =3D {0x3020100, 0x0, 0x0, 0x0}, s =3D {0x3020100, 0=
x0, 0x0,<br>	0x0}}, h =3D {bf =3D {0x302, 0x100, 0x0, 0x0, 0x0, 0x0, 0x0, 0=
x0},<br>	f =3D {0x302, 0x100, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, u =3D {0x302, =
<br>	0x100, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, s =3D {0x302, 0x100, 0x0, <br>	0=
x0, 0x0, 0x0, 0x0, 0x0}}, b =3D {u =3D {0x3, 0x2, 0x1, 0x0 <br>	&lt;repeats=
 13 times&gt;}, s =3D {0x3, 0x2, 0x1, 0x0 &lt;repeats 13 times&gt;}},<br>	q=
 =3D {u =3D {0x3020100000000000000000000000000}, s =3D {<br>=C2=A0 =C2=A0 =
=C2=A0 	0x3020100000000000000000000000000}}}<br><br>The above snippet exemp=
lifies an issue with how the SIMD register value<br>is set when the target =
endianness differs from the host endianness. A<br>similar issue is evident =
when setting SVE registers, as is shown by the<br>snippet below where the Q=
EMU host is little endian and the target is big<br>endian:<br><br>(gdb) p/x=
 $z0<br>$1 =3D {q =3D {u =3D {0x0 &lt;repeats 16 times&gt;}, s =3D {0x0 &lt=
;repeats 16 times&gt;}},<br>	d =3D {f =3D {0x0 &lt;repeats 32 times&gt;}, u=
 =3D {0x0 &lt;repeats 32 times&gt;},<br>	s =3D {0x0 &lt;repeats 32 times&gt=
;}}, s =3D {f =3D {0x0 &lt;repeats 64 times&gt;},<br>	u =3D {0x0 &lt;repeat=
s 64 times&gt;}, s =3D {0x0 &lt;repeats 64 times&gt;}}, <br>	h =3D {f =3D {=
0x0 &lt;repeats 128 times&gt;}, u =3D {0x0 &lt;repeats 128 times&gt;},<br>	=
s =3D {0x0 &lt;repeats 128 times&gt;}}, b =3D {u =3D {0x0 &lt;repeats 256 t=
imes&gt;},<br>	s =3D {0x0 &lt;repeats 256 times&gt;}}}<br>(gdb) set $z0.q.u=
[0] =3D 0x010203<br>(gdb) p/x $z0<br>$2 =3D {q =3D {u =3D {0x30201000000000=
0, 0x0 &lt;repeats 15 times&gt;}, s =3D <br>	{0x302010000000000, 0x0 &lt;re=
peats 15 times&gt;}}, d =3D {f =3D {0x0, <br>	0x302010000000000, 0x0 &lt;re=
peats 30 times&gt;}, u =3D {0x0, 0x302010000000000,<br>	 0x0 &lt;repeats 30=
 times&gt;}, s =3D {0x0, 0x302010000000000, <br>	0x0 &lt;repeats 30 times&g=
t;}}, s =3D {f =3D {0x0, 0x0, 0x3020100, 0x0 <br>	&lt;repeats 61 times&gt;}=
, u =3D {0x0, 0x0, 0x3020100, 0x0 &lt;repeats 61 times&gt;},<br>	s =3D {0x0=
, 0x0, 0x3020100, 0x0 &lt;repeats 61 times&gt;}}, h =3D {f =3D {0x0, 0x0,<b=
r>	0x0, 0x0, 0x302, 0x100, 0x0 &lt;repeats 122 times&gt;}, u =3D {0x0, 0x0,=
 0x0, <br>=C2=A0 =C2=A0 =C2=A0 	0x0, 0x302, 0x100, 0x0 &lt;repeats 122 time=
s&gt;}, s =3D {0x0, 0x0, 0x0, 0x0, <br>	0x302, 0x100, 0x0 &lt;repeats 122 t=
imes&gt;}}, b =3D {u =3D {0x0, 0x0, 0x0, 0x0,<br>	0x0, 0x0, 0x0, 0x0, 0x3, =
0x2, 0x1, 0x0 &lt;repeats 245 times&gt;}, s =3D {0x0,<br>	0x0, 0x0, 0x0, 0x=
0, 0x0, 0x0, 0x0, 0x3, 0x2, 0x1, 0x0 &lt;repeats 245 times&gt;<br>	}}}<br><=
br>Note, in the case of SVE, this issue is also present when the host<br>an=
d target are both little endian. Consider the GDB remote session snippet be=
low<br>showcasing this:<br><br>(gdb) p/x $z0<br>$6 =3D {q =3D {u =3D {0x0 &=
lt;repeats 16 times&gt;}, s =3D {0x0 &lt;repeats 16 times&gt;}}, d =3D <br>=
	{f =3D {0x0 &lt;repeats 32 times&gt;}, u =3D {0x0 &lt;repeats 32 times&gt;=
}, s =3D {<br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats 32 times&gt;}}, s =3D {=
f =3D {0x0 &lt;repeats 64 times&gt;}, u =3D {<br>=C2=A0 =C2=A0 =C2=A0 	0x0 =
&lt;repeats 64 times&gt;}, s =3D {0x0 &lt;repeats 64 times&gt;}}, h =3D {f =
=3D {<br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats 128 times&gt;}, u =3D {0x0 &=
lt;repeats 128 times&gt;}, s =3D {<br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats=
 128 times&gt;}}, b =3D {u =3D {0x0 &lt;repeats 256 times&gt;}, s =3D {<br>=
=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats 256 times&gt;}}}<br>(gdb) set $z0.q.u=
[0] =3D 0x010203<br>(gdb) p/x $z0<br>$7 =3D {q =3D {u =3D {0x10203000000000=
0000000, 0x0 &lt;repeats 15 times&gt;}, s =3D {<br>=C2=A0 =C2=A0 =C2=A0 	0x=
102030000000000000000, 0x0 &lt;repeats 15 times&gt;}}, d =3D {f =3D {0x0, <=
br>	0x10203, <br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats 30 times&gt;}, u =3D=
 {0x0, 0x10203, 0x0 &lt;repeats 30 times&gt;}, <br>	s =3D {0x0, <br>=C2=A0 =
=C2=A0 =C2=A0 	0x10203, 0x0 &lt;repeats 30 times&gt;}}, s =3D {f =3D {0x0, =
0x0, 0x10203, <br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats 61 times&gt;}, u =
=3D {0x0, 0x0, 0x10203, 0x0<br>	&lt;repeats 61 times&gt;}, s =3D {0x0, 0x0,=
 0x10203, 0x0 &lt;repeats 61 times&gt;}},<br>	h =3D {f =3D {0x0, 0x0, 0x0, =
0x0, 0x203, 0x1, 0x0 &lt;repeats 122 times&gt;},<br>	u =3D {0x0, 0x0, 0x0, =
0x0, 0x203, 0x1, 0x0 &lt;repeats 122 times&gt;},<br>	s =3D {0x0, 0x0, 0x0, =
0x0, 0x203, 0x1, 0x0 &lt;repeats 122 times&gt;}},<br>	b =3D {u =3D {0x0, 0x=
0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x2, 0x1, <br>	0x0 &lt;repeats 245 ti=
mes&gt;}, s =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,<br>	0x3, 0x2, 0x1,=
 0x0 &lt;repeats 245 times&gt;}}}<br><br>In all scenarios, the value return=
ing on getting the register after setting it<br>to 0x010203 is not preserve=
d in appropriate byte order and hence does not<br>print 0x010203 as expecte=
d.<br><br>The current implementation for the SIMD functionality for getting=
 and setting<br>registers via the gdbstub is implemented as follows:<br><br=
>aarch64_gdb_set_fpu_reg:<br>&lt;omitted code&gt;<br>uint64_t *q =3D aa64_v=
fp_qreg(env, reg);<br>q[0] =3D ldq_le_p(buf);<br>q[1] =3D ldq_le_p(buf + 8)=
;<br>return 16;<br>&lt;omitted code&gt;<br><br>The following code is a sugg=
ested fix for the current implementation that<br>should allow for mixed end=
ian support for getting/setting SIMD registers<br>via the remote GDB protoc=
ol.<br><br>aarch64_gdb_set_fpu_reg:<br>&lt;omitted code&gt;<br>// case 0...=
31<br>uint64_t *q =3D aa64_vfp_qreg(env, reg);<br>if (target_big_endian()){=
<br>	q[1] =3D ldq_p(buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 q[0] =3D ldq_p(buf=
 + 8);<br>}<br>else{<br>	q[0] =3D ldq_p(buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 q[1] =3D ldq_p(buf);<br>}<br>return 16;<br>&lt;omitted code&gt;<br><br>=
This use of ldq_p rather than ldq_le_p (which the current implementation<br=
>uses) to load bytes into host endian struct is inspired by the current<br>=
implementation for getting/setting general purpose registers via remote<br>=
GDB (which works appropriately regardless of target endianness), as well<br=
>as the current implementation for getting/setting gprs via GDB with ppc<br=
>as a target (refer to ppc_cpu_gdb_write_register() for example). Note the<=
br>the order of setting q[0] and q[1] is suggested to be swapped for big <b=
r>endian targets to ensure that q[1] always holds the most significant half=
<br>and q[0] always holds the least significant half (refer to the comment<=
br>in target/arm/cpu.h, line 155).<br><br>For SVE, the current implementati=
on is as follows for the zregs:<br><br>aarch64_gdb_set_sve_reg:<br>&lt;omit=
ted code&gt;<br>// case 0...31<br>int vq, len =3D 0;<br>uint64_t *p =3D (ui=
nt64_t *) buf;<br>for (vq =3D 0; vq &lt; cpu-&gt;sve_max_vq; vq++) {<br>	en=
v-&gt;vfp.zregs[reg].d[vq * 2 + 1] =3D *p++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 env-&gt;vfp.zregs[reg].d[vq * 2] =3D *p++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
len +=3D 16;<br>}<br>return len;<br><br>The suggestion here is similar to t=
he one above for SIMD, that ldq_p<br>should be used rather than simple poin=
ter dereferencing. This suggestion<br>aims to allow the QEMU gdbstub to sup=
port getting/setting register values<br>correctly regardless of the target =
endianness. This suggestion aims to<br>yield results such as the following =
from a remote GDB session, regardless<br>of target endianness:<br><br>(gdb)=
 p/x $z0<br>$1 =3D {q =3D {u =3D {0x0 &lt;repeats 16 times&gt;}, s =3D {0x0=
 &lt;repeats 16 times&gt;}},<br>	d =3D {f =3D {0x0 &lt;repeats 32 times&gt;=
}, u =3D {0x0 &lt;repeats 32 times&gt;},<br>	s =3D {0x0 &lt;repeats 32 time=
s&gt;}}, s =3D {f =3D {0x0 &lt;repeats 64 times&gt;},<br>	u =3D {0x0 &lt;re=
peats 64 times&gt;}, s =3D {0x0 &lt;repeats 64 times&gt;}}, h =3D {f =3D {<=
br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats 128 times&gt;}, u =3D {0x0 &lt;rep=
eats 128 times&gt;}, s =3D {<br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repeats 128 t=
imes&gt;}}, b =3D {u =3D {0x0 &lt;repeats 256 times&gt;}, s =3D {<br>=C2=A0=
 =C2=A0 =C2=A0 	0x0 &lt;repeats 256 times&gt;}}}<br>(gdb) set $z0.q.u[0] =
=3D 0x010203<br>(gdb) p/x $z0<br>$2 =3D {q =3D {u =3D {0x10203, 0x0 &lt;rep=
eats 15 times&gt;}, s =3D {0x10203, <br>=C2=A0 =C2=A0 =C2=A0 	0x0 &lt;repea=
ts 15 times&gt;}}, d =3D {f =3D {0x10203, 0x0<br>	&lt;repeats 31 times&gt;}=
,u =3D {0x10203, 0x0 &lt;repeats 31 times&gt;},<br>	s =3D {0x10203, 0x0 &lt=
;repeats 31 times&gt;}}, s =3D {f =3D {0x10203, <br>	0x0 &lt;repeats 63 tim=
es&gt;}, u =3D {0x10203, 0x0 &lt;repeats 63 times&gt;},<br>	s =3D {0x10203,=
 0x0 &lt;repeats 63 times&gt;}}, h =3D {f =3D {0x203, 0x1, <br>	0x0 &lt;rep=
eats 126 times&gt;}, u =3D {0x203, 0x1, 0x0 &lt;repeats 126 times&gt;},<br>=
	s =3D {0x203, 0x1, 0x0 &lt;repeats 126 times&gt;}}, b =3D {u =3D {0x3, 0x2=
, 0x1,<br>	0x0 &lt;repeats 253 times&gt;}, s =3D {0x3, 0x2, 0x1, 0x0 &lt;re=
peats 253 times&gt;}}}</div>

--000000000000725057063a38948e--

