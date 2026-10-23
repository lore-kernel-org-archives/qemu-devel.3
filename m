Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1461606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=koi+vkaM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fIsfck9r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4T8-0007BY-L6; Thu, 22 Oct 2026 21:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RQ-0001qU-2v
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RN-0006L7-Ev
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EvjJ772903
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=; b=koi+vkaMJ8z01xaJ
 336x2LOXNexdkwmy+gJ55zM/Y5ZcCMntpq5diTPsuvofkJs8e4Qqm7w7X3kPmaOb
 PPYa8meR7bcaxQQYeMfSU4K6fCIhbVXBOtoEVLPvuPjX/pAcXNbNm8/TJpcss6cX
 j/hoazRqj/NlGxqkaag8U4MOh+FbS8d15rHBO0lj5RIGiKjY55w85MSGYWVxK3Y2
 b6s5XaqnGsyyGtKHinAT5LlYW0mXb8TFdCSGeGoowu5RD8/Vv4/0ko6g41IC82bM
 brWkMlr6eQxWEjeEKivemMWqjhm1xJrnS0FW7aqBuUMmiOug0UhXJ5ptLT2wJaXE
 l3QfYA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtsbtd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so549895eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720277; x=1793325077; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=fIsfck9rBHsdxsjEaJrf/xm4BcQY9zZ9KxNhJYSSsbKVvtGtwqUqHpNXHEVYfDLe+h
 vST1NcO3CNnQxoT4eWB1t9cznVQYqCv4hPQQ1O/9pAwToNO7lcd1Q1QHKnfQ01Qj/Cy5
 hSzFBY10J5GsYRX1mxoMHbVSUuvVnY70lc7EX9HB/YBY0Zm0DaLhfqUcYJhCSbxzYui1
 rC3rBQk3CIdIV6r/pCwVawMgAmH77w959A78pMC09IEI5vBNKLtqLDtSDZv8tcsLHRnU
 JtH6Cx6r0OSUn99OGIj6aT0FF41vvG82nnkIg29QcBAuUG96VdughxNPyo1Ycb9ohnW8
 tqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720277; x=1793325077;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=asXVFBQfsgMHP1xRW+mA8lAPxJrTL8p/IO4VfUKOyp5bGd5Ma4idqf+s1SzZUI+rWu
 3U8NbZwO8iC/h7LHvYehc54yG8rv9pePVjkkvh1f1oJaSo28wT/EwcS1m3pDCZTvdNyg
 KkDDKKxH49JSQjC9BCkKZT2oNuieAQrBU5WoT2WSmQ9VKQ/v5oNh7c7xo1Vgu/gQayGU
 /kDv311VJ3PIdTtwtVGVwuNwo8I3c7LWcV7cUHkCbookPRXJsSoPDUVi2NVlzL6uXIsj
 8EwE+qg/dFf2gkYI/zDzIxf+RUvaLP6SfdvJXNAHDi3pujuk7Yymg4fDmTwieS4Y47Ob
 JFFw==
X-Gm-Message-State: AFq9FYKToFSvXJn8wII9Q8yFk7tl9ZKXsKmDPbWxOhtEiNUwVzTOFW+Y
 mEZgc6WMZWIt40++GCKtYJ+FNLkE920JH852gM/u0aNiyTzm3vQTbHmt/vqLDwl8EHZeuwaZ23n
 iyMch4xxR5j4eMx2TOwd4vgOWuvzDa3tCQeCX4qXFq7CuYTmkHHw8CcGh+NUFY5ubzw==
X-Gm-Gg: AYBFou15PZXAtclm6lN245fWBBzgRS8Aa0TERhLgUkU7dXxkBgal034Hm/DAt5UwEsc
 EAVRDI1reBHSbxvPtCVYaRRxKOf4pHo3KNXAgR13eJ2bOBwWfP1YWCfwa+ON01zdSn3d6K9k8Yt
 wXf0EMbn9M2oFOveKVQeRRYs/kYIHriwWZ+rPvql0sA1PRG6VIBhs43gAFIyBd6DLeebflmfZa0
 EYi56DhULOzEIaVCvOuHAimhJFAPZZIOc4dDdP8VhFXZlVsJdWWh+bHRFmZxIQtUh+NNqrG2zeN
 d6I1HAjUYjtffYd0i/uaCfHMcakn9kuY1zxXMXSWVh6UPpNHDY3Ow6mfzZejllyZvRlX6Ki6+Dv
 vu4rPaQbzTDw1dAGv49i4iHDiltq6CpS5qLxmhSNJb4uCrL+V
X-Received: by 2002:a05:7301:a0b:b0:360:58a9:2704 with SMTP id
 5a478bee46e88-369d97cb733mr997718eec.6.1792720276941; 
 Thu, 22 Oct 2026 18:51:16 -0700 (PDT)
X-Received: by 2002:a05:7301:a0b:b0:360:58a9:2704 with SMTP id
 5a478bee46e88-369d97cb733mr997687eec.6.1792720276172; 
 Thu, 22 Oct 2026 18:51:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 20/43] hw/hexagon: let a machine place its DDR
Date: Thu, 22 Oct 2026 18:50:17 -0700
Message-Id: <20261023015040.2473105-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adabd95 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=aYFWVRUMB-liYKm9W0cA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: eclRPuCLO1e1P3-uogQ53cquTFCamypv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX5E7Eq0wAD51v
 1694/D1vuWbSGIBPtEocabOtoFJ1LJEJk726uGDcv8ZZZ7JjK3sYGCzpwS9zwVnlWyT0TIPoBor
 1eu16tZf6kbxownIhipMxC4gzBtXmcP/T9Vovkk9esuRLdbDThK8HNqX6LUgoGXZjjX4Sl69ayn
 bN2/B2pjPNDin/p3TtHAqk8vaROxv9yrBBt8fT5qslOQfkt9pmp2RmEOD53sOzikcNZ4fNAMcTP
 tehyknRqiOY2pIBX4uS2Sqghdh1d4JesvCkjAwdiZHjn8DPDmzv3wRA/od45zblUmsYiEJeFaOB
 30XNF1EzLbPLE2qqIWaib1D0GZKVfVHQS/9mvO9ShaMgc41swKJGP5K7RPtRvhsivnLGnh1neoq
 esP0zh24Tsn3U4jBk9GkWDaG4L0Y0hjdaUCMBTSrmRbsiZXoEdd10stW9+SL7EnyDW1KhuZ1GZn
 HEMPsL9jv2pCTCFwhoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX2Fu4RIQBTSEF
 aFGCzA4Jddf2PYdYCt8MGhXN9RM6vpt0/o24NfmVmfCzkrBZaJFbX24dF08uF0yQKxPL0ewJWLa
 OfoNrz1vqbVNcttdGLcT8outg2eqiCM=
X-Proofpoint-ORIG-GUID: eclRPuCLO1e1P3-uogQ53cquTFCamypv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aGV4X3N1YnN5c19jcmVhdGUoKSBhbHdheXMgbWFwcyB0aGUgbWFpbiBERFIgYXQgYWRkcmVzcyAw
LiAgVGhpcyBpcyBhcHByb3ByaWF0ZQpmb3IgaGV4YWdvbi1zaW0tc3R5bGUgbWFjaGluZXMsIGJ1
dCByZWFsIFNvQ3MgbWFwIGl0IGVsc2V3aGVyZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hl
eGFnb24vaGV4YWdvbi5oIHwgMiArKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDQg
KystLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uLmgKaW5kZXggNzk2MTdhMDY4ZGEuLjAxZWQwM2NjODMzIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9o
ZXhhZ29uLmgKQEAgLTE0OCw2ICsxNDgsOCBAQCB1bmlvbiBoZXhhZ29uX2NvbmZpZ190YWJsZSB7
CiB9OwogCiBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB7CisgICAgLyogQmFzZSBhZGRy
ZXNzIG9mIHRoZSBtYWluIEREUiByZWdpb24gKi8KKyAgICBod2FkZHIgZGRyX2Jhc2U7CiAgICAg
LyogQmFzZSBhZGRyZXNzIG9mIGNvbmZpZyB0YWJsZSAqLwogICAgIHVpbnQzMl90IGNmZ2Jhc2U7
CiAgICAgLyogU2l6ZSBvZiBMMiBUQ00gKi8KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1
YnN5cy5jIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggOTgxOGNmNTg4NzguLjM4MmY0
NWJkMDlmIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhh
Z29uL2hleC1zdWJzeXMuYwpAQCAtMTM2LDEwICsxMzYsMTAgQEAgdm9pZCBoZXhfc3Vic3lzX2Ny
ZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgTWFjaGluZVN0YXRlICpt
YWNoaW5lID0gTUFDSElORShobXMpOwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzbWVtID0gZ2V0X3N5
c3RlbV9tZW1vcnkoKTsKIAotICAgIC8qIE1haW4gRERSIGF0IHRoZSByZXNldCB2ZWN0b3IuICov
CisgICAgLyogTWFpbiBERFIuICovCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT5y
YW0sIE5VTEwsICJkZHIucmFtIiwgbWFjaGluZS0+cmFtX3NpemUsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmZXJyb3JfZmF0YWwpOwotICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lv
bihzeXNtZW0sIDB4MCwgJmhtcy0+cmFtKTsKKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdp
b24oc3lzbWVtLCBtX2NmZy0+ZGRyX2Jhc2UsICZobXMtPnJhbSk7CiAKICAgICAvKiBDb25maWct
dGFibGUgUk9NIGFuZCB0aGUgYmxvYiB0aGF0IGJhY2tzIGl0LiAqLwogICAgIG1lbW9yeV9yZWdp
b25faW5pdF9yb20oJmhtcy0+Y2ZndGFibGVfcm9tLCBOVUxMLCAiY29uZmlnX3RhYmxlLnJvbSIs
Ci0tIAoyLjM0LjEKCg==

