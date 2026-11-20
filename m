Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65231606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pIBGqwQj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KSL8A0FQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhS-0007tT-LA; Thu, 19 Nov 2026 22:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhQ-0007ru-E8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhO-0000Td-Fa
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:08 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3V38f3027280
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cm7CuEfokN2BQa/Ni+jQ+djFm19unernHkn4hKnQzNQ=; b=pIBGqwQjUkaCgR7h
 uGnw+s5bMURA7Y9OxTKrCEYQKWjQ7zfJj57ntv+uoIfmPZrmf6Lxg9O+SqKshMoS
 hYJdchxOwXuzE5P3FFE3zjccqFO+34B7GIknJy+GYdPoNas40FwCCrbr+28LF5aS
 w3VMGCRDCp70LKoeDVM4lPe7AdPEHTfUYeDOFgi1WslAaD+TBrN0wsh909nljHrW
 nzI6/bVjqC4zK4hDiqzKXypIoEUzGR5NJ5p1Nnk9xOiFL14Re7FPIgW6fkATD5A0
 1r3idihejKPvoxhzXWffLY1UPWqjLKwy+7Ym77QMdLCcIYnHD8hrG4i8ltAKsqYE
 wc63Dw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j22ugubhh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:54:05 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so615167eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146844; x=1795751644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cm7CuEfokN2BQa/Ni+jQ+djFm19unernHkn4hKnQzNQ=;
 b=KSL8A0FQUncWDNuuBRzTX60O5dYcV7VqOAkQHg3rMlQTXAGOQHoYx4+duWYZ1sv7sK
 lMq1c1mFyh5ZBbxbxrzvsHJ81ko+QivJVnGgenJtW59pNUQa3nP6wzE4QasRMNi4X2gD
 IESKN7piU8BsbQ6OUU7vkQw8gTvg5BI35yHD5+sk2CPxcqG4Zd1O8hu69hGzKbhpAxTq
 mHQIN4z7T0ELRG4Va6VmG7u7bYZfZxgwfpc3cGVRIZXWM/yhdMzvg4CvM1Kig335o5P7
 ZbG+/mQciMmlCtO9xRnk4cRNAo9nXnnVWAtCi9wAiqK6ijqIJN6mZhBCTV7VtDN69MNG
 C+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146844; x=1795751644;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cm7CuEfokN2BQa/Ni+jQ+djFm19unernHkn4hKnQzNQ=;
 b=1S7HlskRPBlQa9GL5SGu9moVxOqVw5AvCRcJXUZHQHqAf8XEee2LbUN0DQSLcsVqiK
 qqtcFpzTXlCxSPF8zYpXjNOjjM8ci1J2yA+hZ++FdwYlVzS86ueKiFaHE4uixgV8mesb
 qI3w6XeoqwpVhFGUo86g3XTBJoH+VcPXuCK0cOaTP5XC4PBJDwN5hNxy49HUsTa075Ww
 UmR2zyFGaDGcgkhYKa3usBDOF0/4TqffM0dSXPAQqOpwWjTSRz3lN5mo1lsfrup+8d40
 J0Wt6YOC75ZA3u0Kr4hLGVteKKXfQT20aVH+KM1j7hma00GnnTOZd1RpSru0lmDjMO2S
 Tt1g==
X-Gm-Message-State: APuU4Z9X9mtWltwiu5g25tcYB66kcXh3D45upp1lYZq5TdufXPe/kO2L
 KkzUpXF81bsokmLyEFBWObxA9dB43eJWpzN7xhuJExFirPOR2DnpUDuOV+PUUYxJK3tuQhNkiDr
 KhFtSdGirTI4Y/x4xspwVR6mptHOb8G05Bq8scaiZoEKERSgCA0YsYdo8iI9sAfihRw==
X-Gm-Gg: AZFdTZcgwIK4CFHTs6F/DK44Q9vIpugDYSLM2lTI0bU+DfjhmYYvL5O5TGWIKhm6bz3
 LbYHlwCdEEosFmzFLv5OxSMZHrw2NRI01NHQaDnHs8Jilpu6JDq2hX+lGCJJoqscVBUvGWE4g8r
 gUdM6dPrBUkAED67nw6BkvOr7cbSYoUlMqAfQirWzy8Kt1zsgQdZYMsOQMfD4rDHk+QsIH5R0c8
 ouTT0KRmO27xXCyTDXgOQljQIk3bOyImr3nkhAfSjBF5x6snecMOrPWl0I3YBvdq9e5Z1RFtYX/
 bo5WWujfbAH+8hMUVn0bGJpJ5Nw0tKGxkXwCUePl3fHHTAHua+hJ6K8NQYWjbA/cgwQFjMXPnDN
 ioOiWQS2TPTH5T1hAoEXD04dvNuEnTF7IfYABtD4OpoxXCsEH8rnV8jHUQjpqWFN39XPGJUf1K+
 71OqB/UNMfOICbbUYaRaTK
X-Received: by 2002:a05:693c:88cc:20b0:384:a0cb:a6b3 with SMTP id
 5a478bee46e88-3856f256635mr1312580eec.13.1795146844341; 
 Thu, 19 Nov 2026 19:54:04 -0800 (PST)
X-Received: by 2002:a05:693c:88cc:20b0:384:a0cb:a6b3 with SMTP id
 5a478bee46e88-3856f256635mr1312566eec.13.1795146843876; 
 Thu, 19 Nov 2026 19:54:03 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:54:02 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Anton Johansson <anjo@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 4/8] target/hexagon: HLX, preserve scalar :mem_noshuf ordering
Date: Thu, 19 Nov 2026 19:53:49 -0800
Message-Id: <20261120035353.3215703-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
References: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: mlPHdTKPSGHwd3t1l23SBQNf13pzPnd4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX3T4Rs1jqaAOm
 3eFsxM7UZWfCBoLlxF5TMxAtnXdh/cj6xQ3rbU39t/0NS7nYV3Rwc2yoT6oHa40TTnCI3D6p9Xs
 bVLJBApQ9OBL2YMV8Hwlgoe1JdfK3Bw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX/NaY7ItJP8Qj
 tGziYb7kLPFgdaTg4vUDjn9mZ2akzkXD3Vi80lNwdIFPkR1kNUtPCElBK8a4IC4TzQLjVHrGNnK
 pCNvVoToRUIpKe8dcQaG1cGmSdg32QN1DpSxNm9ZM9kOOjqrE0EUJdsVEYkCTFAbx7J2bVaOIZ5
 2JyjJjDzhVG7MH85wHLSJnkrdqMLuREHx6/VW5WZkRL4+1IW5wDaZcoG2FpW7qcGVZr228M2wzO
 iuoL8j7ks25lFwhNZAkAHE7TiVaHNzG44YrOv26xDkORTafS6ycS+KtlB7K9fS/zjBEkN0/+DTP
 8MPZ0GNXAIvkm/ZEl18Kw6OYiItukSzv0SHO/pzzUCFiCCloO4KSLZGtWWYZv4r/qFTFbLMsJNa
 DXFulIJw0m+YWCqDYGQpXvhJ99h9YgXl560+CctdcB/xIZ/5Jkm/sO6oZMaWW4GyJaqXTcHQXrO
 I2lCN2MsFzDDdRNhM1w==
X-Authority-Analysis: v=2.4 cv=YeEodARf c=1 sm=1 tr=0 ts=6affc45d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KRAAX02eDPLUxZpcMUIA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: mlPHdTKPSGHwd3t1l23SBQNf13pzPnd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200015
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

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCkEgcGFja2V0IGNvbnRhaW5pbmcg
SExYIGluc3RydWN0aW9ucyBjdXJyZW50bHkgZGVmZXJzIGFsbCBzdG9yZXMgdG8gdGhlCmVuZCBv
ZiB0aGUgcGFja2V0LCB0aGlzIGJyZWFrcyBzY2FsYXIgOm1lbV9ub3NodWYgb3JkZXJpbmcuICBP
bmx5CnJlb3JkZXIgSExYIHN0b3Jlcy4KCkZpeGVzOiBhNmZhZTZkYTA3MGQ2NmI5ICgidGFyZ2V0
L2hleGFnb246IHRyYW5zbGF0ZSBwYWNrZXRzIHdpdGggSExYIGluc3RydWN0aW9ucyIpClNpZ25l
ZC1vZmYtYnk6IEFudG9uIEpvaGFuc3NvbiA8YW5qb0ByZXYubmc+ClJldmlld2VkLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBNYXJjbyBM
aWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMgIHwgIDcgKysrKy0tLQogdGVzdHMvdGNnL2hleGFnb24vaGx4X21lbS5jIHwg
MjIgKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggZWMxZDc5ZTMxZjYuLjExYjM5
MTdiOTZjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMTUzMyw4ICsxNTMzLDEwIEBAIHN0YXRpYyB2b2lk
IGRlY29kZV9hbmRfdHJhbnNsYXRlX3BhY2tldChDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXND
b250ZXh0ICpjdHgpCiAgICAgICAgICAgICBmb3IgKGludCBwYXNzID0gMDsgcGFzcyA8IDM7IHBh
c3MrKykgewogICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBjdHgtPnBrdC5udW1faW5z
bnM7IGkrKykgewogICAgICAgICAgICAgICAgICAgICBJbnNuICppbnNuID0gJmN0eC0+cGt0Lmlu
c25baV07CisgICAgICAgICAgICAgICAgICAgIGJvb2wgaGx4ID0gR0VUX0FUVFJJQihpbnNuLT5v
cGNvZGUsIEFfSExYKTsKICAgICAgICAgICAgICAgICAgICAgYm9vbCB0bXAgPSBHRVRfQVRUUklC
KGluc24tPm9wY29kZSwgQV9ITFhfVE1QKTsKLSAgICAgICAgICAgICAgICAgICAgYm9vbCBzdG9y
ZSA9ICF0bXAgJiYgR0VUX0FUVFJJQihpbnNuLT5vcGNvZGUsIEFfU1RPUkUpOworICAgICAgICAg
ICAgICAgICAgICBib29sIHN0b3JlID0gIXRtcCAmJiBobHggJiYKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEdFVF9BVFRSSUIoaW5zbi0+b3Bjb2RlLCBBX1NUT1JFKTsKICAgICAg
ICAgICAgICAgICAgICAgaWYgKHBhc3MgIT0gKHRtcCA/IDAgOiBzdG9yZSA/IDIgOiAxKSkgewog
ICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7CiAgICAgICAgICAgICAgICAgICAgIH0K
QEAgLTE1NDIsOCArMTU0NCw3IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9hbmRfdHJhbnNsYXRlX3Bh
Y2tldChDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAg
ICAgICAgICAgIGlmIChpbnNuLT5obHhfbmV3X3plcm8pIHsKICAgICAgICAgICAgICAgICAgICAg
ICAgIGdlbl9obHhfbmV3X3plcm8oaW5zbik7CiAgICAgICAgICAgICAgICAgICAgIH0KLSAgICAg
ICAgICAgICAgICAgICAgaWYgKEdFVF9BVFRSSUIoaW5zbi0+b3Bjb2RlLCBBX0hMWCkgJiYKLSAg
ICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX2V2ZW50X2dldF9zdGF0ZV9iYWNrZW5kcygKKyAg
ICAgICAgICAgICAgICAgICAgaWYgKGhseCAmJiB0cmFjZV9ldmVudF9nZXRfc3RhdGVfYmFja2Vu
ZHMoCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFJBQ0VfSEVYQUdPTl9ITFhfT1ApKSB7
CiAgICAgICAgICAgICAgICAgICAgICAgICBnZW5faGVscGVyX2hseF90cmFjZV9vcCh0Y2dfZW52
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF9pMzIoaW5zbi0+b3Bj
b2RlKSk7CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9obHhfbWVtLmMgYi90ZXN0cy90
Y2cvaGV4YWdvbi9obHhfbWVtLmMKaW5kZXggNjQzYjQ5OWZkOTEuLmMwODQ0NjQ2YTAxIDEwMDY0
NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9obHhfbWVtLmMKKysrIGIvdGVzdHMvdGNnL2hleGFn
b24vaGx4X21lbS5jCkBAIC0yMjksNiArMjI5LDI1IEBAIHN0YXRpYyB2b2lkIHRlc3Rfc3RvcmVf
ZmF1bHQodm9pZCkKICAgICBjaGVja19oKCJMWF9TMTZiX25ldyAoZmF1bHQpIiwgYnVmX291dCwg
ZXhwZWN0ZWQsIEhMWF9IQUxGX0VMRU1TKTsKIH0KIAorc3RhdGljIHZvaWQgdGVzdF9wcmVzZXJ2
ZV9zY2FsYXJfbm9zaHVmKHZvaWQpCit7CisgICAgdWludDMyX3QgcmV0ID0gMDsKKyAgICB1aW50
MzJfdCBwdHIgPSAwOworICAgIHVpbnQzMl90IHZhbCA9IDB4MTIzNDsKKyAgICBhc20gdm9sYXRp
bGUoIntcbiIKKyAgICAgICAgICAgICAgICAgIi53b3JkIDB4ZTUwMDc4MjJcbiIKKyAgICAgICAg
ICAgICAgICAgIiAgICBtZW13KCVbcHRyXSkgPSAlW3ZhbF1cbiIKKyAgICAgICAgICAgICAgICAg
IiAgICAlW3JldF0gPSBtZW13KCVbcHRyXSlcbiIKKyAgICAgICAgICAgICAgICAgIn06bWVtX25v
c2h1ZlxuIgorICAgICAgICAgICAgICAgICA6IFtyZXRdICI9ciIocmV0KQorICAgICAgICAgICAg
ICAgICA6IFtwdHJdICJyIigmcHRyKSwgW3ZhbF0gInIiKHZhbCkKKyAgICAgICAgICAgICAgICAg
OiAibWVtb3J5Iik7CisgICAgaWYgKHJldCAhPSB2YWwpIHsKKyAgICAgICAgcHJpbnRmKCJGQUlM
IGJyb2tlbiBzY2FsYXIgOm1lbV9ub3NodWYgb3JkZXJpbmdcbiIpOworICAgICAgICBlcnIrKzsK
KyAgICB9Cit9CisKIGludCBtYWluKHZvaWQpCiB7CiAgICAgaW5pdF92dGNtKCk7CkBAIC0yNTMs
NiArMjcyLDkgQEAgaW50IG1haW4odm9pZCkKICAgICAvKiBTdG9yZSBpbiBhIGZhdWx0aW5nIHBh
Y2tldCAqLwogICAgIHRlc3Rfc3RvcmVfZmF1bHQoKTsKIAorICAgIC8qIE1ha2Ugc3VyZSBITFgg
cGFja2V0cyBwcmVzZXJ2ZSBzY2FsYXIgOm1lbV9ub3NodWYgb3JkZXJpbmcgKi8KKyAgICB0ZXN0
X3ByZXNlcnZlX3NjYWxhcl9ub3NodWYoKTsKKwogICAgIHB1dHMoZXJyID8gIkZBSUwiIDogIlBB
U1MiKTsKICAgICByZXR1cm4gZXJyOwogfQotLSAKMi4zNC4xCgo=

