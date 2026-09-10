Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98926C79FB6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 00:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4SrP-0004Go-57; Wed, 09 Sep 2026 20:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4SrN-0004GU-7k
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 20:41:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4SrL-0003zJ-Ee
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 20:41:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689M9WT82729734
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ciIgn0x3lVP7+RLiq9vLVW
 Zeum5agiCAbDahjrjFXT4=; b=jJ0rD2ILRAR8S3K2eWLbICvH2/S2AgiMZ+qbb3
 fg3ZHCxGckEtlJmQSdfu8jcXdZyVo6r9zazsBUweunhuwFmbgYb7em0Bhss2ROMD
 5xrlXdXgBNE28+iWvEXnWTyenJtm0UIbumVMM6Gp6njOglscK6FgWivS07oB8Omz
 XuauH/9MLZsw3wFpbeaB7IRdzkolXLbAdHBeilhONQ3t0hbz4Kdz3uZDc8MJH4xZ
 Sy950/8YpN8PhaG/Clpme1PIEPdHRdMBqWT4QMLz3blu1YrP3fw8PfUEUmNrsCWt
 m1t4i2FwTxa9Y3kZRX3UWfNnUAa9CtKLwTm634k2zj1zhxbw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyds9gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:41:43 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6bd74449818so3271618eaf.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 17:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789000903; x=1789605703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ciIgn0x3lVP7+RLiq9vLVWZeum5agiCAbDahjrjFXT4=;
 b=OE6GvkgH1PnFVgYW7cLENib1XyLYshBf+17O3J8+0npRUdSF1H9awrq+xREImM1Ni6
 IBo1BbTYDxUPrRRXl6x25IpTfL5OuN9YcnNWMY7tS7hJYsDXrYJTBfqM9KmrbKEqpetv
 JQ1gOtKuW8DrtHXzO2Zh63Su5Gp9uiq2e3Dvf2+YhDAu3VVjbQQCNP+ociqlP2rjGqjK
 eGj2Nnr2oIDKyZ6J2HwN2NpVAtFi4Ql5EK0RLxvQHr72kLR0jXfzSoY9g2ndk4BGby2v
 UWvD6oqs8kJcmXzgajz/apPxpYJrOZp+EA5eCa77cD5xYa/LenHQdyJ6U4l3VCbmeKn3
 g7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789000903; x=1789605703;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ciIgn0x3lVP7+RLiq9vLVWZeum5agiCAbDahjrjFXT4=;
 b=RzP6Ce6hSF1kJq+6ksr4i5NITwcXPuvSdkiqmoRSBcLhunD9wY1Zilfcs5TPSTZq8M
 82OJk7xsc64mlq1MiECOWtCrHsMvkgy7ClFyPRNYhxy2Sjh8g8G9j9ZZZrizW3kZLGtE
 tgyNpUhThNtFc/PZvBYjCLqNH/EFFEAc64BBMQFqUkYriV+QZtALoNPlT1Q7IQ0t3lf0
 7ugZ5+0B+l9OlOyLDQQpWJ/1chHkbfsn/mlIsXc0SUFe7p6b1WKz2K+fOjUEj50RQdT1
 Ep0fW6cDhBemkMeD3iRFhoScgWYnyyrppk6LaV9yW4stMCXjQSe1IqlQbzTj501SRMYO
 rUGQ==
X-Gm-Message-State: AFuF++krPrK9z/f2qzbyOP+lhyQNsZhi2sh2WRBIfu9rHnzldPlCAsHF
 CkGMA9zWRODq1ZAqjoOtcKBtqSZh6PpiBjhDCLr9+QCxy56Yk20MV9vhkx81RSil2XaeHca+wrq
 xRkpfyZgCHNSq3lV3UQmTdjM92oaD72kwATGjBNd/c9gIhE3h61gXVTg5gEnKcPaNoA==
X-Gm-Gg: AYBFou05DDmWgt0r/2wzCO2LTIcow4aQrIKXh8gNBV8VqgI7wfL12PgdGQIQ7Nob5iu
 gc0+oFaNAGzDez+WoRnGTPHiCATypWndYjRKbJ0+bzOHL+GRLCfNn0F6Lr2+D9VgVvkstAQR0ZH
 a2CGEnx9cb0PIDOPmloCqOW7U1F7YSQ8hjF6iENNTLtLo/OzwKKo4GK28m0CvVqa0wDbqT/MuiN
 xDSyNSWdulSIKz60VBZdZjwNBF4ZkcqWlqw5nfWQ19vBWqaEVOV6bvPyKtmrZ88GgCZG7C9com8
 CKQm7613744iZXZcEquDGeVA/ErYkBe8Wwiqgxbr0+1dIgA9uXVUgs4RPCvdv0OzaYYswlV0ZyW
 1RRp3AcFreeXZzhFAjIuq3ailSio8vvOc6A7AfhENt3iOtbVW
X-Received: by 2002:a05:6820:a06:b0:6bd:a88f:c8cb with SMTP id
 006d021491bc7-6bda88fcd26mr5965465eaf.6.1789000902749; 
 Wed, 09 Sep 2026 17:41:42 -0700 (PDT)
X-Received: by 2002:a05:6820:a06:b0:6bd:a88f:c8cb with SMTP id
 006d021491bc7-6bda88fcd26mr5965445eaf.6.1789000902366; 
 Wed, 09 Sep 2026 17:41:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143240d86c3sm42891733c88.0.2026.09.09.17.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 17:41:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/1] hexagon: add hwcap
Date: Wed,  9 Sep 2026 17:41:38 -0700
Message-Id: <20260910004139.606486-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa1fcc7 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XgAXcj935WUOF3K5PGgA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-GUID: SG0U7NOrBSA4CPb1N-Soyresq0IhVc9q
X-Proofpoint-ORIG-GUID: SG0U7NOrBSA4CPb1N-Soyresq0IhVc9q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAwNSBTYWx0ZWRfX0ZjnJIcu0fxQ
 P2Xlu8wXwY1wrLx98zuC1J00NWzbfHpnrhDHT2I7mGtAw8aRnsjxPckYORQQzj2ivLvUiwwTDeS
 Kwq877nek1FoeUM4XguhyE+wCw7tFlo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAwNSBTYWx0ZWRfX5hBovnT5fsvj
 0MvjokWunA8oVK4W69vqq+ArJEcX9vcf2zYbBE/WXxtGt5CjKqIznlFEsCWnFMjxxRk15Pji8Cp
 IlgxVlQ5WHzl1Vi0wGps1aMrOZhXwIAldAoQTE298ZVutcJMH2RWrA6zqY0nLuc6BoXaRJJeyj3
 skw0tlx1gvZOXV/EA3tnpXEwlrml+U/YsHcci6P3Pgz+RIsdtue7K4/tfVPm/rAonVuRpVJCfOM
 neOJfdwTVYfztK97bOmk+osDkCb3EqMzphVzRQbZEcDSYgWUaxD3WqNSM3Tgm7WPNLD7WNuNZbg
 FYNYVNUCn3t9/6xEFuS3AgHTvr8+3xHdQCRRUdBTB2GiLUAnnB+Hsz4pwYWHfgkUoKFInE8RdL6
 gspJJNf5ZFZH27QQ0ANVh+6nNzobUQy7u1w0BwkCg/O2hfxsV0+BiJEYNhjbsMpMWGTt09ATolO
 gk97O0biSa5fL9t2s2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100005
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

SW4gdjI6CiogVXBkYXRlZCBkZWZpbml0aW9ucyB0byBjb3JyZXNwb25kIHRvIGtlcm5lbCB2MiBw
YXRjaCAoKyB2NzUsNzcpCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8y
MDI2MDkwNzAxNTA1Mi4zOTQ4ODQ3LTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJp
YW4gQ2FpbiAoMSk6CiAgbGludXgtdXNlci9oZXhhZ29uOiBBZGQgSFdDQVAgc3VwcG9ydAoKIGxp
bnV4LXVzZXIvaGV4YWdvbi90YXJnZXRfZWxmLmggfCAzMCArKysrKysrKysrKysrKysrCiBsaW51
eC11c2VyL2hleGFnb24vZWxmbG9hZC5jICAgIHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKykKCi0tIAoyLjM0LjEK
Cg==

