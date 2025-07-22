Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F24CC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 18:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHJB-0007Hj-Uf; Tue, 22 Jul 2025 14:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueGw3-0000Sr-Ad
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:37:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueGw1-0000B4-4c
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:37:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MC5Fn5000932
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 17:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dHs8tb4QrSbF6tDEooFm2g
 9UWQtBZdHNloTXeKbtrdo=; b=UTvV9usAiwIWHqRwgQdTOT08C9CXW7vdVXuiql
 KMBm5hMSewYuYiYBatOIi760Q7tgW24DfhbK+Siz8wR54hBShARq9JQx/NZQ17zj
 nnFQKQsYBb2YKyJVRD926Vbz6M6PM9w69Sq7HukhOBNvoaLMb8JWAXKPCQLvyvAZ
 pVf7QKftBPJJaWBusk+EQJbBNdMGfpujzUochbachqqxIgaZfj5U1yzjI20qb4U0
 HocGzDYOLWOc23cE62AhvYWajF/+Th1Yp8K0Mri1odQSZnmVHHszD4cf3yeAGjAC
 bDhKWZXG7o68fSNLVe56cs8GX9wN6DTdxiWYd7IZrjFtEHpA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044dj7uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 17:37:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-313fb0ec33bso5927068a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 10:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205859; x=1753810659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dHs8tb4QrSbF6tDEooFm2g9UWQtBZdHNloTXeKbtrdo=;
 b=Tc1xdoJIgdZ8XW3XtekMBX2sev+dLMg/29O221/UzgrK0FoFm9LSdaXWbvEeNw28Sa
 HMib7Zxt/gbPT8Mre0bb4zKZR6VPggfGQWDEwTzBfe1mkUCjkgk75lp2N9fsHoEplLyK
 iFwxckY7LWNhiKD8VCIHedm6ecOFmUNDxszKea9N6jiNBiCE2+/+cKfkC1eSoOYV5gO0
 2tvevAGTafGujWN6LybP8YmT5BygBDgMf2oXzNRS7nMe7avkw6HvfSPOFzESF2L2pqqA
 klklcoPpfWoN5Cd2rO783Sjitq9m/Psw0uRNtXFMVs1v3hoK31v8+o7+ibDSgIDM2p4t
 VsLA==
X-Gm-Message-State: AOJu0YxgoxQ0mAJf41K4ofFGx4Slum4IU636wBSezOEMNqkNy+YE9B33
 tVEbVwRJrTjiOtOMSfQDDndOrU7XMaE5pXs44UpHa88gzAKKL0HBe46+eOwUgd30RB3n4qPNPH9
 4l0WvNbo2xckX3ZnqD4a2dBelwGs46FgbVUrx8Q7xsDEun5MQ4LiR663cb7pTnk5rpXxI
X-Gm-Gg: ASbGncsSDPy7iSrLR7PGgVmT+2G/HWmw6e5v1LnTYg7AlzqRRKDl9fvJFMZ9oJ+Lkb/
 zFxz1R/mUeHjwJbUz1IHJ79FrMa5W3xD7vbhvbXNrTuLRifzIMZEPtc1l4rfTJdwOmO6qLBv2Od
 aVp8uDf+kT6Yk60hWohkOqK/nG93Bs6+3kKNBXhcBy8iGB5FSMrUYQKT/cD2Xtp4RQy3D3fcyZR
 hG0hxbyHcgF+G94ia9q9Cd9z8mNCyvroF6zwA+vH4Ep9hgoWwQ+rmTXROC0ynT+Tx122HTA5opU
 3Uz+fA4t7D0/VBYJ59XWm3xrxgtXRSU4wARNjeayLGBZrtyL3xW1FklElPUz/KuGz0+lBZbEKbZ
 f4V6us9NTQNBIgwU=
X-Received: by 2002:a17:90b:164f:b0:313:2adc:b4c4 with SMTP id
 98e67ed59e1d1-31e507dbdcbmr165759a91.24.1753205858750; 
 Tue, 22 Jul 2025 10:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB7Yd1OLAaaaLwCg/j/N6badbNHgXn0SvI8ZbYDGNvW7YUBaDXes03e729RdDR9j2udxIxJw==
X-Received: by 2002:a17:90b:164f:b0:313:2adc:b4c4 with SMTP id
 98e67ed59e1d1-31e507dbdcbmr165720a91.24.1753205858183; 
 Tue, 22 Jul 2025 10:37:38 -0700 (PDT)
Received: from admin15.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cb5c5da0csm10081180a91.25.2025.07.22.10.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:37:37 -0700 (PDT)
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
To: qemu-devel@nongnu.org, vacha.bhavsar@oss.qualcomm.com
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 0/2] target/arm: Fix big-endian handling for NEON and SVE
 gdb remote debugging
Date: Tue, 22 Jul 2025 17:37:34 +0000
Message-Id: <20250722173736.2332529-1-vacha.bhavsar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687fcc6b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=DOH25g8fJlTivxquR3cA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 77Gde2aeerHiAr1J5vdypHW4j2NEWKFQ
X-Proofpoint-ORIG-GUID: 77Gde2aeerHiAr1J5vdypHW4j2NEWKFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE0OSBTYWx0ZWRfX/zC7dciNC0D8
 C7FHHG86seIpMQ+ZeMab9Fw+4dGlCPVRULCkf3fW1iGF79SjSWFdIliTU8wkgESGZh7ZZYoSozj
 WNTN4OYb42xtzE36SaUOUp+89F7Sm+11+Jr9oKSYdTwt9ndUZqPAd7YLSlxTwNZlj+r3QHCha2V
 U94nxqgSqX5VNYtE2QmtGFSVQpGiUzfiGkjXFj/igy/FNOcatn9s33FHx31avep5T1Btgz+ATZ2
 B8TtX5RlpQ3vwGD3C7qyYHUYQg//7IXMVM1NLxD6oaq3FYbiLAQsLfmkIWqccJaER4nXnmYic95
 Uyp1p7LpmLxXM5S5EegqiBKRZj8jIJVx/JM1iVh/6y+yzPihPtgeetpiG4C8CYhO2HUZERzwW4l
 ildY0VMU3dMpRtf+N66BJt8+FP99xRThbuJVfNWMLwaPGFRk+NVgLd9A8rDcEeFAInC5oci2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Glenn Miles (12):
  ppc/xive2: Fix calculation of END queue sizes
  ppc/xive2: Use fair irq target search algorithm
  ppc/xive2: Fix irq preempted by lower priority group irq
  ppc/xive2: Fix treatment of PIPR in CPPR update
  pnv/xive2: Support ESB Escalation
  ppc/xive2: add interrupt priority configuration flags
  ppc/xive2: Support redistribution of group interrupts
  ppc/xive: Add more interrupt notification tracing
  ppc/xive2: Improve pool regs variable name
  ppc/xive2: Implement "Ack OS IRQ to even report line" TIMA op
  ppc/xive2: Redistribute group interrupt precluded by CPPR update
  ppc/xive2: redistribute irqs for pool and phys ctx pull

Michael Kowal (4):
  ppc/xive2: Remote VSDs need to match on forwarding address
  ppc/xive2: Reset Generation Flipped bit on END Cache Watch
  pnv/xive2: Print value in invalid register write logging
  pnv/xive2: Permit valid writes to VC/PC Flush Control registers

Nicholas Piggin (34):
  ppc/xive: Fix xive trace event output
  ppc/xive: Report access size in XIVE TM operation error logs
  ppc/xive2: fix context push calculation of IPB priority
  ppc/xive: Fix PHYS NSR ring matching
  ppc/xive2: Do not present group interrupt on OS-push if precluded by
    CPPR
  ppc/xive2: Set CPPR delivery should account for group priority
  ppc/xive: tctx_notify should clear the precluded interrupt
  ppc/xive: Explicitly zero NSR after accepting
  ppc/xive: Move NSR decoding into helper functions
  ppc/xive: Fix pulling pool and phys contexts
  pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back WATCH_FULL
  ppc/xive: Change presenter .match_nvt to match not present
  ppc/xive2: Redistribute group interrupt preempted by higher priority
    interrupt
  ppc/xive: Add xive_tctx_pipr_present() to present new interrupt
  ppc/xive: Fix high prio group interrupt being preempted by low prio VP
  ppc/xive: Split xive recompute from IPB function
  ppc/xive: tctx signaling registers rework
  ppc/xive: tctx_accept only lower irq line if an interrupt was
    presented
  ppc/xive: Add xive_tctx_pipr_set() helper function
  ppc/xive2: split tctx presentation processing from set CPPR
  ppc/xive2: Consolidate presentation processing in context push
  ppc/xive2: Avoid needless interrupt re-check on CPPR set
  ppc/xive: Assert group interrupts were redistributed
  ppc/xive2: implement NVP context save restore for POOL ring
  ppc/xive2: Prevent pulling of pool context losing phys interrupt
  ppc/xive: Redistribute phys after pulling of pool context
  ppc/xive: Check TIMA operations validity
  ppc/xive2: Implement pool context push TIMA op
  ppc/xive2: redistribute group interrupts on context push
  ppc/xive2: Implement set_os_pending TIMA op
  ppc/xive2: Implement POOL LGS push TIMA op
  ppc/xive2: Implement PHYS ring VP push TIMA op
  ppc/xive: Split need_resend into restore_nvp
  ppc/xive2: Enable lower level contexts on VP push

Vacha Bhavsar (2):
  This patch adds big endian support for NEON GDB remote debugging. It
    replaces the use of ldq_le_p() with the use of ldq_p().
    Additionally, it checks the target endianness to ensure the most
    significant bits are always in second element.
  This patch adds big endian support for SVE GDB remote debugging. It
    replaces the use of pointer dereferencing with the use of ldq_p().
    Additionally, it checks the target endianness to ensure the most
    significant bits are always in second element.

-- 
2.34.1


