Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92421CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn8v-0003KS-Sp; Mon, 22 Jun 2026 18:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8u-0003KD-T4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8t-0006HF-77
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJcTUj1938647
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=; b=oGttLhsBgjcggxK4
 wwRCjNfpNmrRHFrft7Oh0cFII0EYD1oNfEaMiisbFQN1k2zzj4vIrZpvbU6dOQ/l
 bsTHRw9smldnhFVgNeiKsvBkNP7FmQLD8PbsfCZ4gOe2J2MatIw3/4CbOaqmoDGc
 E/pu7FWDehKA4AweYxSSlOAaONzOoCVS1mBcFRmri6u00LwprQr1GXNeDUFT9U+Z
 hgPYDSKV2PWzBEx7LimxIjfOYHbw9FnwxMb+pj43F6ok0Ypg/2Adi+L+EpLrVglu
 BSbLttKIXPy3EqwWBT+vCSx3yfTOHz+jzSMWf49GS1+am7sljw0Z6zz5UmBH3apS
 Bn/+mA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye9wsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so6661912eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167361; x=1782772161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=TRfT4SWBnrAPRgZNkXwACLjsNXa9uenCXNSXz13y4xqcC9MuYHRGx7VXeq8rUltPar
 wjM6A/hs1uvUop0sA/q8WUfPS6vjosgvzvna9wDClw2FgZqZP3lzwu0QEtk37VY6ZjEO
 hKW8rrfiYcEUYF4e4Pi14Qz11l4VxsjjrKSpuAxQDALar1XsztBbPBjPr7fFvh7YPZy8
 cNTVaj+l08ZurgvJksyJpNELIbjLKn1X7tFulu5XLNKumABoyYcHz+HEI/2o7F/7Ddl6
 0FWasUKhO9JWnmTElukb09MEgwrRmGf8MTSFz6nOnVnHf7h1+JdxeetS4qZvlOec7uHU
 08Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167361; x=1782772161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=Un8w8dxT2aTsU6hcjkJ9mvK4WZhMGC1GhIAottxG1BEnS2kWXUdzCGl3G2r3czzVNV
 rP9EnBe0f2LOpnwC3x/fXpLnSM0DEa5dnsOnX8aW32qmEkJNQYsgA+JgLBysKHXB3r/r
 gyUO6zBpvkQKVBPlN4ERuy/u/qYG0r1pzg5RxXwoXvtuePC6E6ruQL7zbAnPabBhxgi8
 B+mwVE1wV+3dLgISUKpaWOFmyVFuJ6G/HH8P+qrciZPtuHEtdlVK5fOffPdOPPAJIuRK
 9XuJZFhv3EJfJLCXdWkuddpLCLaLDVeyCIb5vwxt/em3WpcPk8Yb//Mt1/Nu8Mh2ZlXA
 jklQ==
X-Gm-Message-State: AOJu0YyqPnVvvuinMnwezrLLbdg8ZTH3t9UqNWKp4ZMJddMjE8HReCwh
 PIlRNC9sqxeXm3evG5UjHNFSnLkSIQaQlbBV41Pvc6+RqPDzQf/S+EhxVzdTf1I4z95BOs56CS+
 HyfWKizssKZWFCOKbwmL2SKaxJjIs9c6ovf+6wWiWn6rxtD2R7xqthsAlGYCsMVywkg==
X-Gm-Gg: AfdE7cma8Wo6LoSBNE9p4g2c+MvbNh3VY+RnnJ/3bpwXbQWwJLKnGb6PbqXs9YknhEW
 VVou0T/n6oqCukTtwUSLbvuho7Hza4wCFUhcEkoqzNs8ZkWM5u/c1YfA9RYsQCbnYZ1IAHlkOIq
 +Icb7VJQy2+96igtW9Vl/hooxQv29aa4hUgNrV5oSOD71H3DGFEepnKti08X+nuhrpSLxOXtfT9
 uw/wh8JXqq+A2GBR3gxyaCp8YxqqD/gy/NcHG/pgfde9zDjrLfm6PIHnxNmVIRv8CH7d2VvxBBD
 JW8D7FL1QaqviC3JMsZLcIP9XlSY/h1HdpQfcwGVrBIXvOehbGAEwEjJTl+kIzuGMkxSjWkMJGS
 T5AyUxyvDtpwiC9hL2CeHZs5VwNu3U+skzEFyrcKX692946TvIF+8XxYmfPY=
X-Received: by 2002:a05:7300:5b88:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-30c58acc1ffmr370819eec.14.1782167361184; 
 Mon, 22 Jun 2026 15:29:21 -0700 (PDT)
X-Received: by 2002:a05:7300:5b88:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-30c58acc1ffmr370798eec.14.1782167360687; 
 Mon, 22 Jun 2026 15:29:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 07/75] target/hexagon: Suppress unused-variable warnings for
 sysemu source regs
Date: Mon, 22 Jun 2026 15:27:56 -0700
Message-Id: <20260622222904.607771-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: OwGw1TlYI37jKOYGqeS59Wwmaytow_pp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXx8irFBlIMfSR
 Z7zzyZNvZWQ1zSvMPHOOxPLa9JGxdN+wHXvTzz3pdSWdfzLjNK1zn8T9vFxsrNQWjkK1haCWOWc
 fZzUVgmEH8IKacL3fLZXE5LzuJEmnGQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX+CB0CiG4Us1x
 t0o7MwtMgfpMInF3tIfd4LkAiybu5+rX4RKA4ohStGGVMlaUT0MxEoZhSGrC6yUyTXXjVfucp8J
 iKnu31JCbakUJaNtcNuM8ExdhVLZpDWa7s6LIf1fz3cy9XZl2LSDTbwQf6Asts3Ok/o0Y4QdrZT
 MXHcHEIu0TF/OgYcx9MpSq55gv1Y2gDCYHxflRP39X1AgBodT1qMbA/4sHK4x+lEDNiwxUiouiy
 zxubY5lYNN2FMsoTbsdIGVHkXNy7quHWX6ClYwaxgJiLrsEPhSHIwf4Qru70NIPUNnkKwAUZ9MT
 ja3YENMkjy4PjGDkGpN5iQMKA7KQK3nTR3Kk3R0U9m83X20ooswA0ALJc6bngb9wZ4/to6vIZC5
 bYXmcPVsz3L7dP0WT/JMq3ZvaKXs2Xh3IHfg4pUFmagoGWO86fr/uiw0O6fi9ug38R7KcRtJu4L
 mq5JnDZweIxeJ4R8A/w==
X-Proofpoint-GUID: OwGw1TlYI37jKOYGqeS59Wwmaytow_pp
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a39b742 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

VGhlIGFuYWx5emVfcmVhZCgpIG1ldGhvZHMgb24gR3Vlc3RTb3VyY2UsIEd1ZXN0UGFpclNvdXJj
ZSwKU3lzdGVtU291cmNlLCBhbmQgU3lzdGVtUGFpclNvdXJjZSB3ZXJlIG5vLW9wcyBiZWNhdXNl
IHRoZXNlCnNvdXJjZSByZWdpc3RlcnMgZG8gbm90IG5lZWQgcmVhZC10cmFja2luZyBpbiB0aGUg
YW5hbHl6ZSBwaGFzZS4KSG93ZXZlciwgZ2VuX2FuYWx5emVfZnVuY3MucHkgdW5jb25kaXRpb25h
bGx5IGRlY2xhcmVzIHRoZQpyZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgKGUuZy4gR3NOKSB2aWEg
ZGVjbF9yZWdfbnVtKCkgZm9yIGFsbApyZWdpc3RlcnMgdGhhdCBhcmUgcmVhZCBvciB3cml0dGVu
LiAgV2hlbiBidWlsZGluZyB3aXRoCmhleGFnb24tc29mdG1tdSwgdGhlIGdlbmVyYXRlZCBhbmFs
eXplIGZ1bmN0aW9uIGJvZGllcyBhcmUKY29tcGlsZWQgKG91dHNpZGUgdGhlICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWSBndWFyZCksIGFuZCB0aGUKZGVjbGFyZWQtYnV0LXVucmVmZXJlbmNlZCBy
ZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgdHJpZ2dlcnMKLVdlcnJvcj11bnVzZWQtdmFyaWFibGUg
dW5kZXIgYm90aCBnY2MgYW5kIGNsYW5nLgoKT3ZlcnJpZGUgZGVjbF9yZWdfbnVtKCkgaW4gZWFj
aCBjbGFzcyB0byBkZWNsYXJlIHRoZSByZWdpc3RlciBudW1iZXIgd2l0aApHX0dOVUNfVU5VU0VE
LCBzdXBwcmVzc2luZyB0aGUgd2FybmluZy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhh
Z29uL2hleF9jb21tb24ucHkKaW5kZXggNzk0MzZlZTI5ZDcuLmRmOGQzYmE2NTg2IDEwMDc1NQot
LS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkKQEAgLTEwNjgsNiArMTA2OCwxMCBAQCBkZWYgYW5hbHl6ZV93cml0ZShzZWxm
LCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RTb3VyY2UoR3Vl
c3RSZWdpc3RlciwgU2luZ2xlLCBPbGRTb3VyY2UpOgorICAgIGRlZiBkZWNsX3JlZ19udW0oc2Vs
ZiwgZiwgcmVnbm8pOgorICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAg
ICBjb25zdCBpbnQge3NlbGYucmVnX251bX0gR19HTlVDX1VOVVNFRCA9IGluc24tPnJlZ25vW3ty
ZWdub31dOworICAgICAgICAiIiIpKQogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJl
Z25vKToKICAgICAgICAgc2VsZi5kZWNsX3JlZ19udW0oZiwgcmVnbm8pCiAgICAgICAgIGYud3Jp
dGUoY29kZV9mbXQoZiIiIlwKQEAgLTEwOTMsNiArMTA5NywxMCBAQCBkZWYgYW5hbHl6ZV93cml0
ZShzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RQYWly
U291cmNlKEd1ZXN0UmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRlY2xfcmVn
X251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAg
ICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0gaW5zbi0+
cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYs
IHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykKICAgICAg
ICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXApAQCAtMTExOCw2ICsxMTI2LDEwIEBAIGRlZiBhbmFs
eXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAiIiIpKQogCiBjbGFzcyBT
eXN0ZW1Tb3VyY2UoUmVnaXN0ZXIsIFNpbmdsZSwgT2xkU291cmNlKToKKyAgICBkZWYgZGVjbF9y
ZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKKyAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAor
ICAgICAgICAgICAgY29uc3QgaW50IHtzZWxmLnJlZ19udW19IEdfR05VQ19VTlVTRUQgPSBpbnNu
LT5yZWdub1t7cmVnbm99XTsKKyAgICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwg
ZiwgdGFnLCByZWdubyk6CiAgICAgICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQogICAg
ICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCkBAIC0xMTQzLDYgKzExNTUsMTAgQEAgZGVmIGFu
YWx5emVfd3JpdGUoc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAgICAgICIiIikpCiAKIGNsYXNz
IFN5c3RlbVBhaXJTb3VyY2UoUmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRl
Y2xfcmVnX251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIi
IlwKKyAgICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0g
aW5zbi0+cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNl
bGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykK
ICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAotLSAKMi4zNC4xCgo=

