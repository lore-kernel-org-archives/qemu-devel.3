Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9339EC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7u-00089w-CB; Fri, 25 Sep 2026 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7p-00086d-6U
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000dQ-0o
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0AYE1489546
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0FmCOU4DxK8OOmzxKrXbHIj5VE1rOQR3TcTJudD4Ps8=; b=fHQ/tWeFR7L7R+ZY
 bRwr+dQeO/DVKZKua6yRjIij3oZyIp4IKrQRem8E4zEkpVUwxl1Vsyrg5uKCExDD
 fCS0239+QiNfyyHY3PLq3uPoIdCQ8gTlQhlU8NPVY5uvp3fXbfiGbVdXwS+9GZaY
 UyXozeJgwM7sWs4V8pr1LMp1cUg1bJMsVMKbd/RPxx0eeRHcbiUBX1wLNXT1LEGk
 ksOG4ea5qZYy48N8jZQSKbEv+bQfl+Fprz5cmBJn5c2wT/8G/y+hsEFGt2cAbFKV
 KirsIK27+5pX9tnnDP9zhLsDovPvjXYxChfvuPDnD9Aaw3h8q4tMbd9PrBDFluQf
 zP5Xbw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr101c4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-342a0e1d8c4so610058eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358849; x=1790963649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0FmCOU4DxK8OOmzxKrXbHIj5VE1rOQR3TcTJudD4Ps8=;
 b=j/TC+GYKX4p0hV/H+aJwdw/L1JZlfr/Uj8Ed4YsMhPzR7+Yy5k13LmiuDd9B1+3GNN
 7MoWcY/sJyMfCLvDsLnDL25XfoA29guA+1TKM7JYoUX7GqKTyCSs/12Xq8zF4IhF9D3M
 ORcfaC7YFkl7Mvar20Bpa0CtgAsc8YgfPxA3VqQruruGXUijMwaV0s2hTEkwWGgqdYH1
 JDASr7GtsA48N261skjYbNszQFcgoIq1+snXRxI0UVAuH473rqbH6q4XbofpJ1JcgI8Z
 F7khXZnmhcl0jvAjDYobd3MsLa2BqENM0DUTKyGwWC/yzzEEXqMZHbFNVvuQ6I/no4xw
 gqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358849; x=1790963649;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0FmCOU4DxK8OOmzxKrXbHIj5VE1rOQR3TcTJudD4Ps8=;
 b=dfpZogNTkc+9SaxeiwPD8q05zar5Ee7bM1q3+CZx5omIsOzt7zJigQDjDqIJI6vKdL
 urLc9ZVVOFBco4YhOP4p1PfdZtsXVL+Jz6wlgrMdiUlCYTqFoCNbyOUf8qONchkducWr
 PY3ooXnW9b/5UZkLvZjrRdFvURqjlHK8tL17XXCvoT2jSJy4B1zp8MNzgtH5gjBHpvO6
 uYYk1XydRjUKUDrCQl2SuIKUrBdDAdRmCgIPyn8ZNlSAxThm9nqpuMQsoI5DSRmC74/p
 VemfdPud2VMX9zg5E2BaeunMiIEMNiBp6RgU6sVD2yy8J/VU4I//HwAwvTxmZTSXV+ws
 jxrQ==
X-Gm-Message-State: AFuF++mUQexzVzv+cNO8YyJ1fHUvLRT9M2MJHNm9dGu8VaiOCTuQ+ARy
 xWJAKj/PB0iFhGWHJBVpd/Cy61gc7Sx9oRAwYy09V5qs9lD2Hmxg4IikFxaRCXxMsyFY2qqcWxV
 rhDWiLZgz//BZm3+wy0dioLRBJcmbGvVYwmBZKy7tXR2MZzkNtUsRLDt+FLLQ1mb8jA==
X-Gm-Gg: AYBFou1XOmwjixr890jKkwVQxuGbtSUKfgUtwcx88F3UPix9KjYM/BiPTgPzVcJv488
 nu95syl46R3aGqR/ecvoIHDgJYta6rOMDyWOWy+DC9g277lTdy0Y1dmb/O1rnarWL4ulOd/XcQo
 ff8IFxlmnbaBCqpY6aThdDLMnPkj6V8em14RcEvpyZ2ZlXIBPy0ljftIhGxe64yx0tIm+7LY52W
 xoGrzrfksU32TP+8qTpRiMWbRFseHx9MDD/d219teFulG6pQXN/kcLKAFToCcrL5cR08Jb/bcmn
 9UKPKufleHkNkEfxUupnb7+FMrbicd7NLbWy8ZRkcG21+ykNyxdbMhUnvEGWl5ObVBwIyjuf4GF
 JSeU8BRFUNqLQxf1FCl8E8nT0AkTdtzatqXRB92JZsz5w60Vj1oC42EXSwg==
X-Received: by 2002:a05:7300:ae23:b0:342:890a:40a8 with SMTP id
 5a478bee46e88-342890a4389mr623285eec.30.1790358849193; 
 Fri, 25 Sep 2026 10:54:09 -0700 (PDT)
X-Received: by 2002:a05:7300:ae23:b0:342:890a:40a8 with SMTP id
 5a478bee46e88-342890a4389mr623262eec.30.1790358848612; 
 Fri, 25 Sep 2026 10:54:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 02/13] tests/docker/dockerfiles/debian-loongarch-cross: update
 toolchain
Date: Fri, 25 Sep 2026 10:53:49 -0700
Message-ID: <20260925175400.1897574-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX3KMzSuYbKuhq
 FtwNDo4KRMg8xAUppNNXyzW4crFy3rGNT/PQ4N301hP01qfN/GT7b1IO5TWCS4sMrkVD32x6mP2
 0ZA2hhhmMshDm7NtD3vmi/K9gc3bPaU8yOdTHgSllDzWYYEcBzzE6YsLzL4dTUrqxYxH0uzNl5Z
 /JVZm+r9MoxVeCIJqgRZoCbWmP3YcwUX0zeP+J0ozUqWiBKl0YKesDh1t5r1XpvJARUinZk25d1
 OBU2XR/lODusZkTRejmQteAQCA2RsNstVbIFVnfwkO1RololPdNkGFoZWaY7e307hPXS4RWYVMA
 NyAMqYUGy5M+csOXiOoOBhvVtxBFvz6ASHqorKiQFb+WzFqGqVR4b/rFsitGd621aeOXssu5TbO
 X26Y0+ellKNMvGbs9uvdl6Lpn0SNltLL7JRkUpEkntpAamMb3YvpvUl8PIjqlKyQr2dWTH+dXLj
 8lJHj9Zc2SK6oavmmQQ==
X-Authority-Analysis: v=2.4 cv=ZfKIpcVA c=1 sm=1 tr=0 ts=6ab6b542 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tz06iiwTAAAA:20 a=ZlYf7Jt0Iy_pvCpuhcEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: CD8bfvCPgaZLuV39tsKqeLwa38x7M610
X-Proofpoint-GUID: CD8bfvCPgaZLuV39tsKqeLwa38x7M610
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX5GgxT7UrqYge
 stoEHZevvHWPqlF+3q25/TeyMEmvHO1c8bzrFVqfc5jecfqLXprXZKbxxUHf9Mi/o11xFWeiiLg
 BcsSYQp0IlpqmbPb+u/0y/pjIo3cJSY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250071
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

The previous toolchain was embedding full libc when doing static linking
for tcg-tests. As a result, each binary was 4MB is size.
With updated toolchain, only needed functions are linked, thus reducing
binary size.

As a result, we save ~140MB of disk space for tcg-tests.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260923000510.218473-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index d2ba07972ce..c3c3c0a4996 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -37,7 +37,7 @@ RUN apt-get update && \
         python3-wheel && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
+RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2025.08.08/x86_64-cross-tools-loongarch64-binutils_2.45-gcc_15.1.0-glibc_2.42.tar.xz \
     | tar -xJC /opt
 
 ENV PATH=$PATH:/opt/cross-tools/bin
-- 
2.47.3


