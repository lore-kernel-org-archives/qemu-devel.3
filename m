Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE08DC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eKm-0000Iy-HB; Fri, 18 Sep 2026 15:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKj-0000If-Fj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKh-0007PE-Fy
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:17 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IHxowt830833
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QICx/B7E+RG
 CmNTQ2EM7GEMTOWVydmIdYf63WTM4b1g=; b=JQssf+T12fEMo4cfWAyWIViZFbV
 7xo2nkprLv8cAOL0dki6TGhgWfn2b6iMA4J/qiHKKYsrvbhJ1RhR2ydbQjkABmeZ
 dA9SyoP9HbMbLuh7/6VA2tQ3zT6SEYhuxoM/EHiiglvrgHODdyedqK3VGvEou4m0
 SwkIEno7K95GBLrEy3zvl4CoH01sMkULbOCFev09jorQ3SXgbCp/LUZW8z2UCqiM
 hG639vMn9d1c90pNR61eHxp7+j2WnT7rSeZ3Ct3AICoj6OulANXZ8K3oUT8C9OqJ
 XZNx+1XSeUiA/W8IAQPtA0T4qKPUH0RVCpWIkAQy8eRsABrjeUoSA/MDdYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsa6mrc7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2dd8920c132so24002995ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789759993; x=1790364793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QICx/B7E+RGCmNTQ2EM7GEMTOWVydmIdYf63WTM4b1g=;
 b=AeaB65zYvJMnTWhEQYDjmzJKIy9kU4LJi57CZkpLRYbE5D2Jpb900tFVUixr0mzbBh
 IkjNgLwIJmEh65rafY1aVyxHE9JsZJKFzB3SEOcAphKAb03bF2VaVRcn+hDERH1FxqDb
 GJPTzi5EBiweRX6ejFIATXYF0mWOz3uVVmFRsQbD8pxHLoS8xEGKC33nZI7qzcv1OV78
 5MUYaQYxxaOT8iscMwz29v8/k/LcVgA3n/rJZSs2gw11BBGQyjDGVH53OJElCAdpe+Wp
 vuOWMKjCDZXG3kVTe7nUtZkEitha+I+4Yp3FPBTcBjHHjSfZAT0j8hTSnryse9X81013
 dPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759993; x=1790364793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QICx/B7E+RGCmNTQ2EM7GEMTOWVydmIdYf63WTM4b1g=;
 b=DoLucLoCUuimdXgKOOsoXN/a1ivd5EArv5SpXoG24Y+kQagWS9GWz9Zpgha1mFyaRx
 WIwHjCe56wqsUI2xV6eX2hHT7jrJ9xfeflD+6CElnqXBaGbMHyGfDgiHf7gbEc2S9dkB
 4gPRvaDvxo18WTbJZbDXjVQAbY1DdozfOOcquyeih/lewEGgCSjj6kL8LibZYsqAevqp
 hlKiiAAEdNuzUSjbCY4G/yQMO3NeUAwrCagnCRkyHVbVD9gaXGlZw7nc9XGwnjBPiElp
 DBbs5BfaQmRQTKrmLJ10CyEMWzMaeFCSvracajXnAp/CkY27CruVMMpeo7a9P2SiU5EP
 RIow==
X-Gm-Message-State: AFuF++mPr/tO5ztcbJIKPlSL/bsrZ9HWOtijo7Ec/c2YZnZPfAdjvGHx
 gBCUmUMnhWAGGPVRmI4nyFRjFOy1163TwJmcE5RuHxiKyBcY8AoKcx/37xIUxzleAPamz+4rXDg
 0sS9KttfMuJrtSxDLviZB4jBsEVGhFIsZD9nhyROWRbZWdKyKJVVyPexsi7yOzDgHwg==
X-Gm-Gg: AYBFou3ZjQcrTioSj7AGe2ep0GmxUkml3IBaLq9mhHeJF4kNVms8tx/YH5IXL18YrsP
 7pYAXiiJ1QQ5rH24DcGUvye/sAXl7yzVN4FciXT59LnYSvY/uTl8mCoQXZ4m0+V35zlR5VPAjNO
 1BjwdPTeAr37+IC3fu1z28uYD83vMgb4Cf7w7Ru7+g1eA6kVcien5fyEnxjnUNPGpbGa9VYvB/q
 ns+VjAGzIAqYsWhtZZDo9cBTTKiWbR2TigLerB0uE4Os7TnIdpJJ/3xJU8V2ri1umsQUrOYl+BD
 sCQajubx3sD7PkYT2RsVUhreygFsFTXZdbmo3STe5WRhDt4L9CaZ6Bal34jK7MIo7vQfOcgPyAW
 Bb6YGMTjptvHrdbfJLTZNdPYXRx0BKEaXcGJwDAjcKdSmOcCVx0z+d7fYXPU=
X-Received: by 2002:a17:902:fd8c:b0:2dd:ad74:ac22 with SMTP id
 d9443c01a7336-2ddb1bd6e1bmr77238415ad.29.1789759993357; 
 Fri, 18 Sep 2026 12:33:13 -0700 (PDT)
X-Received: by 2002:a17:902:fd8c:b0:2dd:ad74:ac22 with SMTP id
 d9443c01a7336-2ddb1bd6e1bmr77238075ad.29.1789759992965; 
 Fri, 18 Sep 2026 12:33:12 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a716sm810682eec.8.2026.09.18.12.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 12:33:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] tests/tcg/meson.build: fix host fs mount on SELinux
 enabled systems
Date: Fri, 18 Sep 2026 12:32:57 -0700
Message-ID: <20260918193259.704462-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HHdPlTYyhuIqRBGWiIgPq0k8cOYQe3bP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfXxNhLQTmJXbyY
 Bj/5gKurmktuiW2FS95eQ4U6nHl74ZMsFcOciq07FLB8b4oYtkUtq2NLXakomNbb1oHo/1Vn9pV
 CKxNf5+UnlFYphZejokKzZh+5qyk2AE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfXwFjUC/92NUhB
 XcSs7hb2vy1diS2I0QRSzimuRBDQ979Df3w3PHlUmX2Ta7EgdnMuRWQFvPoLpTKOFlKAFPAAVMf
 bkU0CTSt+1OrbVM6wADeanisBlaNPsxhFgVlfmsey74B4L39NGVtv/wPeGuwmFuDzf9Vz+eGnie
 xalOYOglgbWmvwiFZotjUsobsxfFDSlhRMekvbCFplZnk3pYh2sqfT9UrVJQnNLuQAJwjzIw2xf
 iRwNOGyZ70ZsuvDZ92BmsjCnIzK9u/avdH6BndaZRK/+YsDhEqyHFF93XjXEVvX1jhEoeOQjvzZ
 7hSiQJo9HnM/95lK43C59iJPA5o24ePmolb9cDS5b1diJ1+bL7PpXc6A6WBUZ2S5nY7iIp0ou+V
 PDZW4KAoM2f3PXQvqsC3GPX5TqfR75O1aU5a55YikyPDOHS3WpovYwzYL+xLRXuaWAulip2vhE/
 Qh8PKB5a15roS2IGhFw==
X-Proofpoint-GUID: HHdPlTYyhuIqRBGWiIgPq0k8cOYQe3bP
X-Authority-Analysis: v=2.4 cv=YYAodARf c=1 sm=1 tr=0 ts=6aad91f9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=q-u7UfepXwwUxeN4VQoA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180281
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Fedora enables SELinux by default, which has the side effect to block
writes to host fs done through containers (docker or podman).

$ podman run -it --rm -v $(pwd):$(pwd) docker.io/debian:latest touch $(pwd)/file
touch: cannot touch '/home/user/file': Permission denied

There is a :z flag for mounts, that works with docker, but not with
podman: SELinux: relabeling of /home/user is not allowed

The right solution is to disable SELinux label confinment with
--security-opt label=disable, which works with both podman and docker.

Reported-by: John Snow <jsnow@redhat.com>
Closes: https://lore.kernel.org/qemu-devel/CAFn=p-bXoctWNEdERPBL-SMRPYDisban2e0-mxYjws7UVcjVzw@mail.gmail.com/
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260917221117.274619-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a5e0462732d..75f0a52fd22 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -277,6 +277,8 @@ foreach target, plan: tcg_tests
       mount = mount + ':' + mount
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
+            # SELinux blocks modification of host fs by default
+            '--security-opt', 'label=disable',
             '-w', here, '-v', here + ':' + here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
-- 
2.47.3


