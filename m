Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9665FCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBJ-0001a3-Vd; Fri, 19 Jun 2026 18:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBI-0001Zd-MF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBH-0001UW-2t
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXdvq1251243
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=; b=SbyjIlvf1QTguikk
 NnicwKhQsfFFwEJvv7pjkx6F0fsCvFwn42kQxbC+Zh0hp1ERMYEisANq2wcNp2p9
 mDEHvDQdwPUhwNm2/TO6gChqTFHC7VIPJBlcW9jT0aWF5IICGP18Npp7VM5h1RNQ
 HkwFaWVDTh0gJ52Zlegm6U1wmoxWaZWDjhsD26V6V7I04w4agHG49joXmZIPL16P
 zc45+dr7IoveodKbx1Q2hWJW0sUuO0gAh+HqLEzGcFUZdIGSkJOoUvtqRk+51Ihs
 ez5A0on+gC1TQqTEEddl+iAWSzUWQdwEdhw/XxpMe6A4kIOnQK6k1lAnjhddDv3O
 cwlcNA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewbgp8n24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcbb34e57so4147745eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909961; x=1782514761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=B2NtCQNG8K5tSpmg2A73nZaaJx9fibphdf1sVVptMED2X0k3a0njUKPkK+LcckA/+R
 cX1ZOMQE9+iGWf2vhzLye6DFON2qAVTOgDsg78GykgSpHmfm71jY65Hfd9jN0mLQgOwx
 vUBfVqzMYuplxT0dHG0HNlo5GVxU6hDZKBPSvUxtS1DnCSCCXqP+MtAnTKKmIWJgHTrG
 seQjfGzLRqXKrF00PXwtGR9OtSQKYaMqlb43h3FVVkddo4HNIoxAGLrb4qsjVgr0ygFh
 /gENIpvuBKBf+mRIphMS6rKpX4gBoVp0+Q+ESLG8xfrbfOTIUuF3wuTa8s67KLk5vxH9
 LVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909961; x=1782514761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=snH5kTb8NnA7WujfgyQu/QE/uAuLOffm1+CU0duW70BNZBH43LvGtjFQZsnhS/FBpq
 aQH0NtgQ8ZMeMEbGrqFZmKX8oyWOJyUx7YdU7q7kZ8bzovSmTMgumIVNPp+zzh7V22e0
 FvbaLJlYHJiO3w5HtUEKmNATb0YNaCQCnb7liZXdukBiYAci2LhTQh+uTud4zica4J7A
 nHwV+hAYW4lNvHJJB+PF72kVyKpxvr+1EI9V9rCpIPLy5UXb6tKCAYhlLdoBvVzSp7/R
 gmqxV0JRv1aYsjIEervWX18ZFCFo1NRpxzUPdG7UgIpT5AAJlndi/kOaG5itpjDQ8Jct
 WCiA==
X-Gm-Message-State: AOJu0YyOcI+CJYopULW12Dl0g6dY/fWGtz6XFwkQWrdnFe8HlWjiY+gG
 Qse3wBfRbNJV1/ekpHHwSS5H8Z4gDG3zps8Q0rXEP066SW/riX86R8lLBCQsI1lp8ToA0E7oqlC
 5UfyCffUcMWTx2wwURx3I+vlM4nKS3eD6anp4hjNhmHj1T15WRT2mGcF1eaz8aNz1fQ==
X-Gm-Gg: AfdE7ck8dGKtqEJ56cV9jKCIxnMperCpthCdqc4vceGz/+fpZM0TD9PlJoAa+TRvZl5
 uRCG82Y+qT27IhyRteh+2yXfoyL58uBYtskcHkpvrz3dSFDaT923MKXRpv8tSI/FYJzIiJKhric
 /pjysoxXpehuX/yPQalGWLcj9eY0P3XhnwO20BwdMRBweHC+KqrNvW8Xxi94ntAKsgnIarf4XHt
 tAqotIv5IEdIesEO/jLbaz51QpZubokWb2AcKZM4zbTllqyExlZwG9fZBzeChXGgtrSG6RF6WMd
 AAVJ3BTtJo+g0rh42KQPMwctNfBcAJswGl4KdfW0bfcAWzjSkKa3/9QlsGeiCBtE/LjnSTPS5py
 fihmda9i+HkPn+T7iN9icrKcalLT2S1jv1BJTNiR6bpxIgdVbiJZSQWK7aT4=
X-Received: by 2002:a05:7300:6c9f:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-30c071533c3mr3332556eec.19.1781909960723; 
 Fri, 19 Jun 2026 15:59:20 -0700 (PDT)
X-Received: by 2002:a05:7300:6c9f:b0:2ea:c085:44b1 with SMTP id
 5a478bee46e88-30c071533c3mr3332542eec.19.1781909960234; 
 Fri, 19 Jun 2026 15:59:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 04/74] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Fri, 19 Jun 2026 15:58:01 -0700
Message-Id: <20260619225911.159473-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 6c-ehlLKEEhz-fEho7I8p_V9OyKBCILC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfX9WMSpihXdYXK
 H7GPxeb2aauZlb1ZfUz22P9er7fB9oKNEdvkPPZA7aRgQILiYljRUEtos8qdGxF3p82UM4Crukr
 6jWXhnktd1DhCYM67iFVFBiFOEsPlRhzHfczVcAvL37CX9CWe0+gjlF/TZ9loIQ+6s9tC0BbweG
 rnoU7cyHjywKf8CUlODIAisgQwchaswVSj5+qR+5YjPvmLSJAywbFTGrkIThp6I4kxXRsfAjKhA
 5Qi2sA0KAegXq3v5gCzctHfttWjEAfIu8ZuhNugSTfZofg+2AxoVvLfQBQed+An0gecmrn7nMQu
 s/nrnhXsDtk1adSnRDfsJFwsv3E6kUuN3kFjUCQvtQ68S3/R1sa8WH8FfRH1vt8rR9L6LfpHbxi
 moDby7i5KbEKitLGmazenZbR3cpeF2rYyeEPU63rw6VmRptlbSwu+n7bNiUkMcLPNn5rHYnfsih
 MCumx7KsBauGBIM/EOg==
X-Proofpoint-GUID: 6c-ehlLKEEhz-fEho7I8p_V9OyKBCILC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfX/tFg1WpZfjSj
 9epEVgDgp4TC01xV9xeO4i42NCvfMeP2kLPGsJRM5c5H4/MGNbkyC/tuc/EvvSkipuFwS0084Lm
 3Tk8/1beBzuBB6rrqzd/MFlVn2WGVtk=
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a35c9c9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZLKCIdW5I75hk_SXmpcA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190220
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBlMzdkNWE1MTRmMC4uMjgwYWVmMGRm
M2YgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjQ3LDcgKzI0Nyw5IEBAIGRlZiBuZWVkX25leHRf
UEModGFnKToKIAogCiBkZWYgbmVlZF9wa3RfaGFzX211bHRpX2NvZih0YWcpOgotICAgIHJldHVy
biAiQV9DT0YiIGluIGF0dHJpYmRpY3RbdGFnXQorICAgIGlmIGF0dHJpYmRpY3RbdGFnXSAmIHsi
QV9KVU1QIiwgIkFfQ0FMTCJ9OgorICAgICAgICByZXR1cm4gdGFnICE9ICJKNF9oaW50anVtcHIi
CisgICAgcmV0dXJuIEZhbHNlCiAKIAogZGVmIG5lZWRfcGt0X25lZWRfY29tbWl0KHRhZyk6Ci0t
IAoyLjM0LjEKCg==

