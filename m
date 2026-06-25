Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88919CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckuB-00016m-U9; Thu, 25 Jun 2026 10:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcku9-0000u1-Qa
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcku8-00009L-2n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvVu1754106
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=; b=HF8yyvQb4pAmfeS2
 PV4rkcbV0y+TZGj1cNeNdFzUmnijkHtR+qdC2LtqCPSmyF9iaK+xxqzibGX2AWyM
 2ZSqMJ61hBhWJ1VH/FQzRXzzlE6sgHVhiwGejwNJuv1cgsoH1cIC6n/xyDMhytbc
 Sc0AxL8Xj1mcLY8EGWwuNHNz9Hc/1nwCtInwzD+7J7ZRPy4eN3QKDKVPDagQcJpe
 NafX1l9l2Y76mPZyGVm9mNQbn94MckhBHY7z3toYUyT2lZsPhbmjMMOsL2Ah3Us6
 PuOvJbLg1+66U+rYR7xa7FpxAI4NOwBJwxmttNvNERSItiRCkejdCg7I2i67IBiQ
 92q8TQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q26yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:17:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c50cd6cbcso2572319eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397076; x=1783001876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=R7/jMQbC/YazH0HCuLRviuBbLT5OCS6KWFiPIwkUF41rGnj7GfAPYQAEqI/VBVd5XR
 SxGhyX7qullIrezVGgcCFHPlATFBL+JWmt3iuvZrMaEcDh3fEZOCLJXuvFcJI7AC81PG
 UFoUJb/vizSa3o4O2IIY3ZMFBMkhywlCq2hEBWQkng2o2b37rq/lXJZQw1d0qJRIE7dk
 hld58GDDbHOQIwUHrfqca79CQZg5Vhsd4Dl42t/jQ0P3LOLlq38u3HoaF8iHH3bjLs0N
 QKA09L317sxsjoBfWgCC6VFQDgBJ809iOw16YCFrUjGzAWtYUHXvtZgh803+3tqAPgo/
 9EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397076; x=1783001876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwPVW3CwUQS2/lnObn+K7hYU+7Hhy6ohC8oxC7MFC5M=;
 b=CtooWuSi1D8HgYuSWxwg7YMBddNm7CrVNbnRd+1Aq6OH12r/cImRxHvWGduiyM3CI9
 o1ngTEskNT1vtvXRnC8jvCUbQLa5OrZwEOHd2PPn++ac5apUB5a7/jmFqs/Cwvpm/xVm
 /xPinR17qu8MnzMOpvQuv/wUESzKgKtJ6T/ojpTqOX6eXq3mkwKZiy3RIhjzPKxBJw+0
 gYuokMxQNo04uwk87JVC6Wj6NSy7+1z8Y59ieIEoyQTDXfesj73FJEJiA7BtbMS01++c
 ccqaXalzN37R3XqwGUEzlS+4uKQoYxt2EZrBpyGKxF0CWulUe3FSzkxTmYgjRtsZlL8J
 H3FQ==
X-Gm-Message-State: AOJu0YwMzdxHnYrdMJWcgy76CNl17WnxQA7Xdi0kWCroQBdDlDv1VcEy
 +eTo4zIhjqQJTw139U490ZFUhU8G+YK26NPcPaUhhuEYTPuq5uyM47ytKMaNxcFZTfF+iUDVESH
 V8lsZzm0Dc0INzrC+x+q/9HxOv+bmuNgilcNdHV6jgjTghOeVMHMackMbUX6QuObiMw==
X-Gm-Gg: AfdE7ckUaEZcSxO+/dKuBtS9z5gmVi32uQVrcml30dSu0wfIDpRaKkmlPGWAOD0Tzp/
 vITQHr5pZrjJnyQrJWIH6vUX6ioLodB/3umRGFvHv99PKviQGEjBo8lzdaO/hZrjjUOomZjcbVV
 GI1FZ2YJRf52GAfcaqHpjjvhJic1YmEFvY6AUl+WMlx91teVzTjV4A2umL7WmLayfTkKrPT5xrR
 qRUp//uXMm1wN/cuzNHk1/JvK9kdeLy6BSrgYIYFJMvjK5qD/M4TXMX3UEnLFdlNhNXK5E871FK
 5Nrbb7qmnYtZGhXkJsyzRyahh7ZqZD66dVCxsToFpWGdS9R1jp/x29R1pf73yvEy3cVTEAauhet
 1HDC5L4oNwjAsJ4pGfz0VWWq9lpGvAJRHIMNxDjfE+7GS1lmw7JG1en2UI8A=
X-Received: by 2002:a05:7300:f108:b0:30c:5807:abbb with SMTP id
 5a478bee46e88-30c84cb1ab9mr2648518eec.20.1782397076063; 
 Thu, 25 Jun 2026 07:17:56 -0700 (PDT)
X-Received: by 2002:a05:7300:f108:b0:30c:5807:abbb with SMTP id
 5a478bee46e88-30c84cb1ab9mr2648493eec.20.1782397075419; 
 Thu, 25 Jun 2026 07:17:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:17:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 35/76] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Thu, 25 Jun 2026 07:15:52 -0700
Message-Id: <20260625141633.449487-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ez8qVy-gxJSfmjyzprHt7AIS3O50tfL9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX/51Quz+tQMG+
 5rFwFS2Cxp2XDGFPt5NYx7DwaZ4la+BETVE1rsZPoH32jPk1qgxjv5qTamygycjT2Q89++A1Y1s
 fJ67qG+QAzsG54F12IJq0klTdC+p3QA=
X-Proofpoint-GUID: ez8qVy-gxJSfmjyzprHt7AIS3O50tfL9
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3895 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=StfCoqezVcLOyubjZekA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX3cF383SQtzZc
 c3h0RqjggYChJKH9ogV0hkfj8pQ2mUHXRieNJA9Ti4LiI8AE5tebwHyXXRwMK+P7ZqwRE9P8MaL
 kwBx+mSNdJW8hVULzXPMRQHzl76cykBRKj5cedpxykic0bed3COhZAcYeYXTwCoY4WOAnG44f+J
 ls3ezpc/TAwh2Z5wy39YU0eZ3CKq83GEdFtKe+9hYRUV9jq8TCfpwbDMY5FktavPuHV1EOHS/sS
 IoRDhR5nRbaysLAa1FkG3ccXjUFZRWGKaDkEcfRyKIFvb3SThS6oKkWcuOsdYSje8ZN3Rm5pMpn
 AqTR+vN++3Rb2QZlJIfkaszg8qGWvMvrTzsVhbXEVsYr1jwIvtleQzTWMoeXZxAeGXGF5XgIuiI
 svwudttsbyJgJwDMs0hRtUF3dmVOJjik2cs9d/TBzlsG19AXHSyTr1g0EMNyI8t7DwRG03e/d0O
 vwmgGR9ExTGlF5LTGFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBZGQgY3B1IGV4ZWN1dGlvbiBt
b2RlICh1c2VyL3N1cGVydmlzb3IvZ3Vlc3QpLCBNTVUgaW5kZXgsIGFuZCBuZXh0X1BDCnRvIERp
c2FzQ29udGV4dCBhbmQgdHJhbnNsYXRpb24gc3RhdGUuIERlY2xhcmUgdGhlIE1NVV9JTkRFWCBi
aXQgZmllbGQKaW4gVEJfRkxBR1MgYW5kIHVzZSBpdCB0byBwcm9wYWdhdGUgdGhlIG1tdSBpbmRl
eCBpbnRvIHRyYW5zbGF0aW9ucy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxv
cnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
cmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAg
ICAgfCAyMiArKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAg
ICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgIDIgKy0KIDMgZmlsZXMgY2hh
bmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IGRkZjZkYTc4YzE4
Li43YmExZDMwNDdkZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTQ5LDggKzQ5LDI2IEBACiAjZGVmaW5lIFZTVE9SRVNfTUFY
IDIKIAogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9IRVhBR09OX0NQVQorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIENQVV9JTlRFUlJVUFRfU1dJICAgICAgQ1BVX0lO
VEVSUlVQVF9UR1RfSU5UXzAKKworI2RlZmluZSBIRVhfQ1BVX01PREVfVVNFUiAgICAxCisjZGVm
aW5lIEhFWF9DUFVfTU9ERV9HVUVTVCAgIDIKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX01PTklUT1Ig
MworCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9PRkYgICAgIDEKKyNkZWZpbmUgSEVYX0VYRV9NT0RF
X1JVTiAgICAgMgorI2RlZmluZSBIRVhfRVhFX01PREVfV0FJVCAgICAzCisjZGVmaW5lIEhFWF9F
WEVfTU9ERV9ERUJVRyAgIDQKKyNlbmRpZgorCisjZGVmaW5lIE1NVV9VU0VSX0lEWCAgICAgICAg
IDAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2RlZmluZSBNTVVfR1VFU1RfSURYICAgICAg
ICAxCisjZGVmaW5lIE1NVV9LRVJORUxfSURYICAgICAgIDIKKworI2VuZGlmCiAKLSNkZWZpbmUg
TU1VX1VTRVJfSURYIDAKIAogI2RlZmluZSBIRVhBR09OX0NQVV9JUlFfMCAwCiAjZGVmaW5lIEhF
WEFHT05fQ1BVX0lSUV8xIDEKQEAgLTExMiw2ICsxMzAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogICAgIHVpbnQzMl90IHRocmVhZElkOwogICAgIHVpbnQ2NF90IHRfY3ljbGVf
Y291bnQ7CiAjZW5kaWYKKyAgICB1aW50MzJfdCBuZXh0X1BDOwogICAgIHRhcmdldF91bG9uZyBu
ZXdfdmFsdWVfdXNyOwogCiAgICAgTWVtTG9nIG1lbV9sb2dfc3RvcmVzW1NUT1JFU19NQVhdOwpA
QCAtMTY0LDYgKzE4Myw3IEBAIHN0cnVjdCBBcmNoQ1BVIHsKICNpbmNsdWRlICJjcHVfYml0cy5o
IgogCiBGSUVMRChUQl9GTEFHUywgSVNfVElHSFRfTE9PUCwgMCwgMSkKK0ZJRUxEKFRCX0ZMQUdT
LCBNTVVfSU5ERVgsIDEsIDMpCiBGSUVMRChUQl9GTEFHUywgUENZQ0xFX0VOQUJMRUQsIDQsIDEp
CiAKIEdfTk9SRVRVUk4gdm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdv
blN0YXRlICplbnYsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDA3NzNlZjhmZTc5Li42MjYxMDBkNDNmZCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMwNyw2
ICszMDcsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKICAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fR1JFR1MpOwogICAgIGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyAgICBlbnYt
Pm5leHRfUEMgPSAwOwogI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VWRU5UX05P
TkU7CiB9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGVkOTZkOWE2NmIzLi5jZTViYmU5MmQ1ZCAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMKQEAgLTk4OCw3ICs5ODgsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3RyX2luaXRf
ZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdSA9IGVudl9hcmNoY3B1KGNwdV9lbnYoY3MpKTsKICAgICB1aW50MzJfdCBoZXhfZmxh
Z3MgPSBkY2Jhc2UtPnRiLT5mbGFnczsKIAotICAgIGN0eC0+bWVtX2lkeCA9IE1NVV9VU0VSX0lE
WDsKKyAgICBjdHgtPm1lbV9pZHggPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1N
VV9JTkRFWCk7CiAgICAgY3R4LT5udW1fcGFja2V0cyA9IDA7CiAgICAgY3R4LT5udW1faW5zbnMg
PSAwOwogICAgIGN0eC0+bnVtX2h2eF9pbnNucyA9IDA7Ci0tIAoyLjM0LjEKCg==

