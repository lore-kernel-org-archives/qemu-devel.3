Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC45AFF885A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 00:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGQw9-0000Hn-QA; Fri, 24 Apr 2026 20:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGQw5-0000Gy-KF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:31:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGQw3-0001AR-S4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:31:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OLpa0j720235
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 00:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mTdFEshc6SKhYBVtl+Fcs8lSuAh8/eXvges
 r3pFa3WY=; b=PbuK0nWQVevRVbjZrIsMQuOChK43B0HZciHfNgGz+kx4MH26C/x
 29ON3DZx4rpZpqtnrP4VXq4ufC5QmfnEOCGCIoVT86jdDepaG3/niRHhy0U/5dfO
 8SdoiqBNGPj8i+LSwFGnr6bk4RFtZaKTMvps6NiBZsbbVweXr1Q3Zd20seh+HIfI
 DzfSM7qIuu7+Xjakjg5VJEGpOWrbLGfDIIuHycILdebqyCJJQDvpiEpX4QZY35YT
 DUNHyM9CRLeKrR8DZ+82zbgBUwugX/Cm02YsD+ZgRLRD641/sjKCN5KKb32LhoO7
 qYZvyZVANtTmN2WDsQ90rjICnLyaaR1gpuw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5rw7tc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 00:31:48 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so13192521eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777077108; x=1777681908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mTdFEshc6SKhYBVtl+Fcs8lSuAh8/eXvgesr3pFa3WY=;
 b=IKMkdcZEHtjhkfD2sX5v8AOb4OJSpIPG57XJ3vFTdyfAuNBJEdpWzrpEwOq0WkbRGh
 bAMkElbdfIHze6fwLJ++gxXMdHt8AUoGKapmy+dSWEQ679SMu77itjV63fbNL4CwuFCQ
 12vpnEP+7r6Yd8LdX93/DvxYci3UIJEEsDohXW6NeT5tCUVPf65FtDOSvO5ZV4AJe+pW
 FKFFp+1HY7VifXgUGn16BB0kDruTcKSLjGG1QRzaFoMcNDH0dR0CErqPCIa3gwonhj3u
 gJabeyqwUyJ+J30b3bSj6gjsqNimi6vlxdfFi/+kTea8Kbg6AZ9usKf0bZSf0nPpAZGi
 8+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777077108; x=1777681908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTdFEshc6SKhYBVtl+Fcs8lSuAh8/eXvgesr3pFa3WY=;
 b=CrNwk+6b4YPTxEhmCp1rabPcMTPfrUvArBK6TciQSWcKcHS3IjqdghnLu/sHvc5JEl
 vq1CMGmjxcgYMMJ1s/EwYv7RzLVgxJiwYbppvGWnsqTYYV00upYrALJYtBBi//nidgS9
 EhYwgOps3LxOE+lgTwRsJywzZj/4EfFd1qCi5+aJ4ZyheG5EzQG2O2cNDxYdfhOuuvpu
 w0GzZ1d4RobewR9Vu2gYHmMynCW6IIrdQr45l1eVmJg5O8lOMKrhN7gUN/i6Qow1w3OR
 hykpxNxTFMCqWEanPQ6wVvGr9Cry0EnJa65exMdBA/Gtg3RzCAX2WRQl0fSOFShEMsLn
 VKPQ==
X-Gm-Message-State: AOJu0YyWpKE18v/KEY2eivQPxz+eS+wkqEzWCEy2bR2y6Z7DWYuN5mo0
 tyTneSdRu/l9VeZFh2h+0P4RhOlPO33ji7C7GnMebO/GiKnlJnpUmdI7WJMS/UmXdAbPIaxa4g6
 RO5TNtsjyjuSF5Sf9w/VdwYXwty9vUxBhNlClpOqj4fInDmLITGD8KEwNQ4XSpLCjTkQP
X-Gm-Gg: AeBDieuzv0zGrvl9joGjMHOtVwi1fx+OJbBMRbaXrBHbvglShTiZ2yyuqE+C4S/tx3d
 zBNVvJUmWkLBRRJf93JaJZWLTyVY8ynzrbKInQlWnNO7Oazffr+P+PHqIMaE4ezP2uUePyhbfu3
 O/al7jxHBX8pTBrPDSMeHyLj25bET7ywvUSN12m0Flp9Io8SYaUptkJukV/jnKiICcJBJ37sgr8
 BQNHrAexF/YsWUmZb1WnsooIQ6tXfKx0k39D3Q+YnkIxSfOoj9srqlln4x50E3onZHg5idDC/e/
 aN3d9yoNjE10KzeDBiC6Vv+xlfHDSSy39t5L3OjlHhEinL5Mz74ImSbEhvwyqp7jfC6mhePiNtt
 ZNsgbeSIUi7bGa+/HA7slIALYeh3Oma4rKnmSqYzRyBQ/9ogbcStCylzwXtrbUkmmyMWKgOjh7V
 WXnbfdqH73S+MqBE26
X-Received: by 2002:a05:7301:1e8c:b0:2e2:4979:eb5 with SMTP id
 5a478bee46e88-2e46c48a953mr18586503eec.10.1777077107950; 
 Fri, 24 Apr 2026 17:31:47 -0700 (PDT)
X-Received: by 2002:a05:7301:1e8c:b0:2e2:4979:eb5 with SMTP id
 5a478bee46e88-2e46c48a953mr18586475eec.10.1777077107397; 
 Fri, 24 Apr 2026 17:31:47 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa3ce1sm32510323eec.4.2026.04.24.17.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 17:31:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] Plugins update for 24/04/2026
Date: Fri, 24 Apr 2026 17:31:38 -0700
Message-ID: <20260425003140.1688666-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69ec0b74 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kfRmgs8x-W9Iq8vi5hIA:9
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: X2v-pRczYIz4SnxiWlXWVyFvGy7vFRiW
X-Proofpoint-GUID: X2v-pRczYIz4SnxiWlXWVyFvGy7vFRiW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDAwNCBTYWx0ZWRfX3JHOT6FsaC1C
 OsDXxO0UMjRd+l3x6JzYEuFbSORzLYgXXD1l9KTgtAjSUmmCmYVFz1kaGAIRX/SsrPdqOsUzJ0A
 VoEhgM3YcLwVBqR9/ZVhAHljdDPjH6nXA6565M94xa1uQ3vLNvT7thdVsDYxXsPO/db/RHSoe1r
 Nwlc+9wIsc6vcOz86QKaKK2x02/c7SXkGWK+qLg14uQe8AZw1xN9CHUSBLABBmBPq3jJXrTkVag
 SA3q3Oztmc3NnrJ5UUtL1Wc0QbDjqG02eBmr5/kM0Jxt8RBjWMgpyg4uzBUFUHREU1wvpVSO5BR
 6TaB38p31bK0GATjEYSD19P424ZTLFMjuMSixzqsTF0FwK5ffWrQsVOZhNd+EXivnK2JfAlCtfy
 1VRMyLqiVz1NiHWws5Hul3OAbGvXMQnXiWgkl+qAP8SdSb8cIh5tly9VGK1kz/x5svlHLi5Ireb
 xweUQTsl3gSfKw70oxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250004
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

The following changes since commit 4bde339ecb41b16e90810233ba5ee2fa87bd443f:

  Merge tag 'pull-11.1-virtio-gpu-hotfixes-230426-1' of https://gitlab.com/stsquad/qemu into staging (2026-04-23 20:51:57 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20260424

for you to fetch changes up to 068076d4dfe29ca71626beaa8840c47c18eeb332:

  contrib/plugins/uftrace_symbols.py: handle missing source line from addr2line (2026-04-24 17:30:50 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/2] contrib/plugins/uftrace_symbols.py: fix issues to (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (2):
      contrib/plugins/uftrace_symbols.py: fix symbols reading
      contrib/plugins/uftrace_symbols.py: handle missing source line from addr2line

 contrib/plugins/uftrace_symbols.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

