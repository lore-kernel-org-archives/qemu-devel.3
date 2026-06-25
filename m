Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0748ECDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckt0-0006f7-Qc; Thu, 25 Jun 2026 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksz-0006es-P2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksy-0008Qr-Ag
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvK13078245
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=; b=GNJ4wDZBHpHqWWc4
 g10aDTDrdtSh9UtDfqwv5NQSQfFZNY9erXvD7cGzcejw1A0K1wlvzoMDw41UlbId
 xxIn5VppZNv+2gqr6uTK4p0d9w7Lh7YnmTiHM5JUPnbzP5hp5nrqO2Z6l+0GNWB1
 JMkytj+ZI114GkNV5ISpqVPmckArYGI2hiDeKbMngjVHw/TX9jXvTKo3AUrhAJf8
 ORhHDSHTxi0iZuQF9BdLeCmNf6MjCsNRLHy3hzy4pKfNjvvxtuNY7imaQhOg2Ezn
 E4/CDdXrgxrzSQxyMlxIGyYpPm1pKSexj8Op7stiUdnCr8DneehKI1cHNgybYMXL
 phAjXg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0yynsj3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:54 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1370417c0bfso1041653c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397014; x=1783001814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=G49yuWoaJbDdf3Up2flwvwCFkPavKMvfu98IT9CnjbVqIadOqD7zDjdYHvn7NYjZGQ
 H3+7sGAwLD2OYiVvL57X8qLwesZp2nPYiJ4uyp1cjbJYxnj3aJ3YKt6sEbwVdV4LERBF
 JrIgOEYCpJl7ntbWdseZGhRSdY/Ux2cyx5v/MGouypUZbbviBKOZn+CVtqG3dWT0JC3u
 5t+xnVEz0PxlMSp5wk5vcyspCVMsEnuUtWsv2pZSkzWl/uweZxd1viIu6X42dheI7NnS
 5p3QV6Lmbt03r3prLbWrGpbMt+bY60qjVLzmoTt401StwvjcZOirUmoS31cDlNADS5pW
 l39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397014; x=1783001814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=akHFVisJDbmBFFMLQN2z4af12XW5M1jZKu+CQ2LFdG0=;
 b=DKyYPR4/1igWvRiMjTxWGL2m8wBU53nLjKFJLxPs9pZeb/gIqWIkO44ikSCSITkNgJ
 fESNpM/QYn/Iqag9B0YXFONdegDN3v49IfPrO96U9GvLJQ/YVykg7Nrlyf4YXYQIec1H
 rbWH8oou619g7OvJGst/aSsv9tAsqnFlYAD4hz7lXqG/lh1p0Izg0a2YlhZWCkIeD9Za
 BiHuSP1xj1wgM9p/+9q/4zJZ691yw9G1QHrlM0ENZ6eSpqqMvtQ9MQPFXRlkfVIEfWQe
 61rrsOX47KyuDp6LUOmVyzYyIm1MKO4mDPRmypaeeyM6ZZOJcN1FS+3XR5qeuPxJXc7e
 VfjA==
X-Gm-Message-State: AOJu0YwVKPq56ttYfMtIRe0yUG+vjB+6q1m6ZYMGZcD8sjtKpvqrM29K
 S8L+uKzxPkOBIIXE81Ag/YIMct7UUa7//scVLfsZBHlxpP9UBAcdboHIhJrgK+yOLw/mBlq3QJz
 yCXqOo5NYHiyCaLvBEk2FubFmGsrFBAb+R/4fPZF1RzCW38jCVAPVdcUnLX7d+2x9/Q==
X-Gm-Gg: AfdE7cmqxyXXxQREUONrkBWJcWBtl0qy8Jni5IwJTqyG8NlmdQFS2k5/cF+oPvjBOe9
 Z4msh9VwSUt2HaGG27STN1k4zFfB2IVWQY2tgdYi35kaTNnrBtwO8NAAoJgX52DcBjXu6dJDml0
 fbIx654yOGM98VzEE5S9KuZJod95DVqSd3yRfKJ/IQalLcrNPB6BJPGxsS5vqTDxqVCbKRftuoc
 mFlQfGQyps+5Na8snyi26a6CKsaV6bD7LSupd2BaAoKwKEtxlTPMPM7MtJ8qwC1Zj27N/A/Baq0
 jqj5SEjQ1iYiRKb8/hMPOO3WaiHaPWP9U4T25IIo1/tixEGTLHLZ7TpE4X+V/nnd+0mYV/N+ZCc
 DwjZcW15iRcJlpKGR4YnDo0VkTSoCzjYxiHa1+oCABPINHIcRRrfsnheaNxc=
X-Received: by 2002:a05:7022:1281:b0:139:b0a7:9df2 with SMTP id
 a92af1059eb24-139c3c1f6d4mr11357746c88.7.1782397013786; 
 Thu, 25 Jun 2026 07:16:53 -0700 (PDT)
X-Received: by 2002:a05:7022:1281:b0:139:b0a7:9df2 with SMTP id
 a92af1059eb24-139c3c1f6d4mr11357715c88.7.1782397013221; 
 Thu, 25 Jun 2026 07:16:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:16:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 07/76] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Thu, 25 Jun 2026 07:15:24 -0700
Message-Id: <20260625141633.449487-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX9AlqFkBlFbl7
 +S6E3q3ZnFuRn+IkuMjVj7A5unNpL0y3CEVv9KXD9mFY5KEvPmUQMuStleNfp8K8EnRWhtJsobt
 G6TdH2zGEzAqvQmIqi0kwBKk+Dwbmxlc4pWEYYinn5BeR+FmAFh62ZelkkpYjtNUuyXDA/b6bPR
 wz+NfcdmObYv22obKgknJaygiNG/6IXNaC7SmCHUh1Bc0gxac3S3TJ7Roo8EddW3dMdoE7fXBZa
 N1odGtR59heB4As7k8CFj9z+vT7dhWNIUOCg0iGEz7ye8Fa4AI/Ib2fvqQzZHGeasz43UpAHxeW
 WV6Ndu/nA36c2hHZjYhWxo1osKKSAx3HDjAA6cgOGesd1gA+XSe9p9mt7Hm66AT41UqRlZJnbg3
 M2/9sAdudhfVkmwsbAFEVtpEMvqNdawqEP8fgoqu9NQfs/5C/pqOLdihMBwCS7vI+FQdW3riYdh
 BOfMSYsnp7N3NTuvMww==
X-Authority-Analysis: v=2.4 cv=aoyCzyZV c=1 sm=1 tr=0 ts=6a3d3856 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZLKCIdW5I75hk_SXmpcA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: fKpmxBhb3P9mB3gP47yLIp1DwyfXF34O
X-Proofpoint-GUID: fKpmxBhb3P9mB3gP47yLIp1DwyfXF34O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX18lT0COaeiJ2
 3J6q3A0Ud+M7ZG7vAX5dDf+mHdvs5N6azxEFesKz99MRYz4HhGhuQHpAYylYYfSDLOP0AvR95hO
 4E/4dg+wbYacNQQ0+j04U4UxuL6C4zA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

