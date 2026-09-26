Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0BBC9832F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 19:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAY08-0001NO-Pm; Sat, 26 Sep 2026 15:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAY04-0001M1-KB
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAY02-0005t3-Gw
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 15:23:56 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQj71329839
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uM/LhxK7EcKQ/5Z/oLu6wZhFPG6yeQGsSvXlABH+/kg=; b=My6lev4Qarw4ITTL
 LPptzymVFNAUYDhA3Nl1wI2+TW30I1R5c0FJcyAQ36o2FnRheSEV+HMYBvUO9gcr
 1Cq1H51IaWun3oQkQdDx1ZCTlhGs100q66gy79NGJJC3yW+2vtlOQoFKbJi97fDf
 kEuwrDiJ/po5/CL5/9NR5r8e11F5I22XYIS/cQjCkGI2LkXEUQqi6JFn3lrBpNPK
 ECKuZPxFRoSvCwwsx2zX4n96yxpm1MN8Q+Fae6ZpGwfi23bV2us4SGCgmPnT8ofy
 vQyRJA97003gxuu+fLnfZu0bNcu9ZDk6OsyhBLpNjzvT3zxDDDI9VNv/2D4b9b3K
 nS1Q/w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50s9r2f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:23:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3437d0cc8c7so1936478eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790450632; x=1791055432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uM/LhxK7EcKQ/5Z/oLu6wZhFPG6yeQGsSvXlABH+/kg=;
 b=H+efoBq1SKdNqjzH41OnnCKa/95lHfKoCh0GFJJgWK3yXVGbPk9V4yUBO1XqJPpm4q
 0OEnmE0wilemegGONAQiFVd7Jq9l4QuXhf0pZn5cNsg2/3+DCNO64iGwTHhXUIbimqy9
 oAam/nsvwKFoUH5j/VLCBtNr7QwpJ6kBJr8gCIbE2/JS4b79apQ7WhUXVee2TtPu1jks
 bO7wkjiI4M3rmThefQeJL00bXW5zRLeuNuKr8oywdZvXGNKL0dUozPpO6pbuUwJ2LlQZ
 BSqRO4HqKK7ggMMhSJkcDNN/q6fuViKSmBQpzsVUQvyhUGOuBEjT4GsIMtupZ4plCwce
 e6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790450632; x=1791055432;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uM/LhxK7EcKQ/5Z/oLu6wZhFPG6yeQGsSvXlABH+/kg=;
 b=t1G2CnyQrPUsu+SfF72tof00AG6u6p3IqwgvocCMCGzkwydyyEonkHP4b0NJnRMI+d
 +8tEM0D/QiAz8WfgIkfRrsYw9ky/NAxPrI5/VM/S7H+woKZHS67dA2Bdr400+xwTDsgM
 dPbFfUDxo4aSAJkUF3v3Nd+oTOV1GH4n+3Qst6zlwDLTo2qedZt/txOaQdQaJPblSgvr
 1SrFYdHZWGzZrpkXy+a0NtlIhoof9xu+xTRuxIz2YO5OQUelsQezpDPI/DPNOw/BeFTa
 uJblZjG7Cc3yYEYum33xXBowz45KX0OU65XdqSwBMIcWEkecPusY3nFHdCDPDNs7Rkrr
 QhFQ==
X-Gm-Message-State: AFuF++lHpI5a6EMu80nNgOlTg4baxm7rFIhwrS+W3/qSBTwV4aYyqxd8
 iFqV7P2gZPoVuRL7tGB1nBHDPbF9vqEA5i/f/PHBDU3xJFkOe28OadGLRmzQ9iFp+1Dcc7UpK0v
 wH2vXeOPzrmR/eyE9EOaseSyyoZbVKmyUMJAo1olqZROyXEp784cZ5vaSMw95rytVWA==
X-Gm-Gg: AYBFou0w6ZzEmbFZuUotSPYR+tpyx0K3wgJfyxumvq0VgXuO9e4kD2g+BIhpSYjKshd
 XBU4sKV4Vn2AzlZLZ0PdKyfdjcU2yxPrlsvFVJcPwso062FhGzoYWnxAhrJ2gzl6O1yH0EStEOE
 zszi0CaORnFRL9SG/FMwOaIFTF0rNEuRZAlKDsTAHqtL5Qt7GQSW17YZkAegImfaCZadYPm8Iqc
 aJcl1ejHcEQNnNZu9AIWRUQbFiL+UzpceSJs/CkB3xHPUbsLaePlnS6D7DUR3QDsKSoM4uN+fqQ
 FDsQSW/q1Ywz41LaQ3a7/hAynuqZ2pg/gNYMmisC+PIfIIqUo2Itdyvjh2lHHp1xatIo5nKQ5r4
 LFThNnVqweVQ71lKMPU9jiJ+6H7uwE6erj3pzzrRTnOUtVLg=
X-Received: by 2002:a05:7022:1703:b0:144:f4a0:a399 with SMTP id
 a92af1059eb24-146ce775c78mr4022510c88.1.1790450632334; 
 Sat, 26 Sep 2026 12:23:52 -0700 (PDT)
X-Received: by 2002:a05:7022:1703:b0:144:f4a0:a399 with SMTP id
 a92af1059eb24-146ce775c78mr4022486c88.1.1790450631854; 
 Sat, 26 Sep 2026 12:23:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145aa0cb6b9sm13526271c88.1.2026.09.26.12.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 12:23:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com
Subject: [PATCH 09/10] linux-user/hexagon: add v75-v81 HWCAPs
Date: Sat, 26 Sep 2026 12:23:37 -0700
Message-Id: <20260926192338.2702952-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfXxOd5kp8xSFzA
 jcJbrHCMR0qNTQnhdwwFdAJ6TTtZNn1VIFkX95+yupXfXsP8uemszLNc3tHholOX17pmcquggBa
 D0Y/d9Z7yyVqQwKiqU42z6SVKQ0Qahk=
X-Proofpoint-ORIG-GUID: T8IOLaLXAsRn0ziGvDT449_5YlHmuD--
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab81bc9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ETimc_qDDV0PxRHoQOkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3NyBTYWx0ZWRfX40S79O6C+lIo
 FgoWaTyXQbYABibuAZ0dbzT6KNyoudFzLpQVY+sMw5iX01epB3yGsxqR91aMfgo/HX+rrGgzAcl
 qxXoEA3rndO1gqy0PS2lAcoyXialarEMCn2tJ0Ihqv1JtFaeD8vsfvEKyHYDcaHhD2QXo13TuxZ
 070ts2w+SrVgPLPZ9gJirBkecIwuOgZWRSUBp4pX1LUCEghdUWQujt/HHU09kqPeWt6EGs/jWCW
 f61wDFqrmQ9VRBEtEv9sm/HWkzJio3q/tZMFDdo+/Z/x1HIz2W+Kf6nap+1sRbd9GiVAFqQkLET
 erk+sNTXjyVlvKp1ZYeO2Pi6AjdvWya98vmn45BlcTpMqMpIrJ9eoE0vq1lIJbbHQcJjvquB/eW
 pRuMQQbUYZNnI8mVqwJicrd1z+J86NbWavwf37Nth5kwhhWKxT2lCEz9yhPWCLQtl8Q/A9bcUwZ
 DJmYN9OPa+GLYbdK5+Q==
X-Proofpoint-GUID: T8IOLaLXAsRn0ziGvDT449_5YlHmuD--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260077
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGxpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMgfCA5ICsrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9l
bGZsb2FkLmMgYi9saW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jCmluZGV4IDQ0MDUzMmVlNDEz
Li4zYTZiYTRlMTMwNCAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwor
KysgYi9saW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jCkBAIC01Myw2ICs1MywxNSBAQCBhYmlf
dWxvbmcgZ2V0X2VsZl9od2NhcChDUFVTdGF0ZSAqY3MpCiAgICAgY2FzZSBIRVhfVkVSX1Y3MzoK
ICAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjczOwogICAgICAgICBicmVhazsK
KyAgICBjYXNlIEhFWF9WRVJfVjc1OgorICAgICAgICBod2NhcHMgPSBIV0NBUF9IRVhBR09OX0lT
QV9WNzU7CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgSEVYX1ZFUl9WNzk6CisgICAgICAgIGh3
Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y3OTsKKyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBI
RVhfVkVSX1Y4MToKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0FfVjgxOworICAg
ICAgICBicmVhazsKICAgICBkZWZhdWx0OgogICAgICAgICByZXR1cm4gMDsKICAgICB9Ci0tIAoy
LjM0LjEKCg==

