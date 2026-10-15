Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3781DCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRfv-0003Ot-SJ; Thu, 15 Oct 2026 16:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfp-0003I5-3E
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHRfn-0003Di-Jc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:03:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDo5Z2678060
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C8cupKRSrxJGyQd5s1v28b8wrXtKRq3VoUpd4DHrCEE=; b=Lcl9jIiTdfgR17U6
 8SAXhA+MCodFBFUDQ4cCCUQr+sE5j6Pdgh7hI/Veo+Lj2Oiz9MOCo0j7hSDxK1w3
 MjFA+aZ54rEPz+88Y0O1c/mm+ESv6ZUwkvF2ECmufhaomLlS+nJsBTTf4RVNCjoc
 giBWVideMdt/xNuaKEvtxBijywNjZ02TCd7O1xRicRYzRpAxDkEReBUZUooQfqA5
 2UNda8PRcsHVULT9BHcqinGDwUOpZyuorqF2qIyJc2HWZFBWHULe6VXActeeTLAw
 KqHNxgGrB7NGFvpJb4Q9J5Z3c5g7CUBMmhUNywCIYjpLEoZRqiKf545FdavsXBI6
 Gi5zHA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19t94m4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:03:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3592749a017so278632eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792094609; x=1792699409; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C8cupKRSrxJGyQd5s1v28b8wrXtKRq3VoUpd4DHrCEE=;
 b=HBtQGEAWuK5GS987NmZraVrINJdReD9Tkh+cvVRST//aAqnSvqwHn5dWKm/nq+PxKb
 /PPPfsa6JE0WwHw4F9JrPEAzdhDwA6Ivq4Z3d1wjOnMajGa08+qKnULu2+u0wihpVAH5
 bS8mVL0FtDoLJE6uh+k08P3037GXhAMCz2GR7WpCRrbQdmlcE67sjGJEYOSycEuJrdIa
 UQrdqoNN/+T2eupOuN+nEO22Y3Sao9sr6tI87LfyGX0XSkGzsMHH/6MqTx3C2nsZwbCZ
 KfdHWan0kSNvGzokzX/bVTC5zJA3tl402dqplaP+hQHuKqrwHTKUtGp38x6OAHeCPMd2
 Cdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094609; x=1792699409;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C8cupKRSrxJGyQd5s1v28b8wrXtKRq3VoUpd4DHrCEE=;
 b=kiGNtGCN961joqGOE/zBtlamrbrnNoyRJylL15KlLWqbLLIGSruMMO6dWLF0x8FQwW
 BIEk9TF5fb47GgZsqCKmprg+a+FTYzDzgo3ukuN18spAFgWg7APJ7QEB26Eu7tMSfs7w
 6mFxUDI4pDVR2BMptiLFujdBKok8E8BFn6OP4pPiOJZCrWFYetMmEp2YsV04D/h1+1yE
 lONDwsW29KCh/XY0oqEBRObrfBD7xGgEVjlELrYBRNCVPIr8JS6W74/N3CLoaU6zdY5P
 16o4QVt9Wg1gbnEgzQbtXuIHJTaMc5cgcOnNxq9CnbRP4XNPB+oIR+ohRuAaalvNoxel
 EDnA==
X-Gm-Message-State: AFq9FYKY5qdKuM8wEX5USVOf4zWzHqQmGnQAZI6Uyc9vjLyXAhQNkWoV
 +MseK5oROsruRKqrAvkK/A4kBGXcDiYpjoAa0QRev0wGmJ/PdpZ0U5lgJfwyx0Lcq4Mcxk8qYwo
 vsPSFIfMKsqMqEKXeQMDVQL5Dtv81ETcQTtU2/QodNYXOmmO9e7HXN0K1+o8CX9V0qA==
X-Gm-Gg: AYBFou2l6FA3/6zXK1LXYLtdpQ7vlyXsK30M7u2t9ys2iACDSlnvVX6y5hK+ijFGwB8
 b/6cLsU984wrFDnHBx0emMxDYq04vcYtHD9/KJRHP7A79sUJrSd49Q59aI37lKye+iUuDUJwXJa
 RPvQv9w8ptly4H1/qPOX4ggxN+BoJlP1zFLH9r2i61tgHweYMRg4F3COPwVqhRsoBbrynCCKHII
 ONdiKVv/On3bEb6UZLpPnbdE77KxGMsmhZ/GhUC0HfNDwKz9DVoDb8o24/UTFAt+YdTwcuLLmRS
 39rfxmxoQoSuBKs5nE4KckVn9JlgLp5aE5Xij3Ydrrpo3Gki9fsnKss8YRlYVJVnprCsWIFEoLL
 uhxQBe7sBzMLDcmqpbPW7PNHCELBQhIUU4/8ZX1kXtpHHmkI=
X-Received: by 2002:a05:7022:7e0d:b0:166:f097:6f10 with SMTP id
 a92af1059eb24-18258376404mr1211910c88.11.1792094609099; 
 Thu, 15 Oct 2026 13:03:29 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0d:b0:166:f097:6f10 with SMTP id
 a92af1059eb24-18258376404mr1211873c88.11.1792094608310; 
 Thu, 15 Oct 2026 13:03:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a6d6969asm1347058c88.12.2026.10.15.13.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:03:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 4/9] exec: correct translator_io_start documentation
Date: Thu, 15 Oct 2026 13:03:01 -0700
Message-Id: <20261015200306.1602540-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
References: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: bKQEBIO9RvVu7KirhxfWiVRnK5Dlbhdz
X-Proofpoint-ORIG-GUID: bKQEBIO9RvVu7KirhxfWiVRnK5Dlbhdz
X-Authority-Analysis: v=2.4 cv=NqZE4MdJ c=1 sm=1 tr=0 ts=6ad13192 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=g8hvdXb3kVhzYHBvyzQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfXxqoYEFkzIezz
 sPak2zVsDde4EJYwD3YA6U47SzK1LR96q4ykNlQ/071+/sEWXQP8ciYSGtDUiOuDJxIamzQZC+D
 rJ4p96Wd5HZW1sHID1ZTJuJT0fQX2cfvgM55CWlwXReOFrRd/FzbhgmxWIyIYY//uqaZ2YbOfeH
 I2ADcfZInT21UEZlPSVET/PBh1n+fldF/vBKV09sWt8EJJl7Rx0+3UDvlhCJ8w+lcHFMZVEcv1F
 Cf+9PxVCc6z9F6Haq5EObr3GLriYVfSHSzuWhOs2InOhTCHh47RxiPFcYJ/WCUeXYUC6Jn6rVTq
 ucZNq9WarvePs/0b/BcdevVrQj31tE+xIF9DGXJhOO7Vt3c0eUxWbm2f6bQtB40JNe7zZz5aAPb
 0V7eh1KfFKlk/qHFvCraPBMOvRmpKGNh3KqvHHQAtKQapwYX1aKVl03qrZ0UcZGDkiY85JmIgQh
 MleV6EqdQnnP7usZEug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3OSBTYWx0ZWRfXzfHIlKcg/rPJ
 2bqM05k3Xp1WjCvOekDT5lpKQMSI2/KmZBFkkvUeUMR8mHXWoyB8uDDjaM8v9ez6mH91XZmAHd6
 hzN1hnKIDV6EtHv6eubTRax/Nv+XvBY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150079
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGluY2x1ZGUvZXhlYy90cmFuc2xhdG9yLmggfCA1ICsrLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvZXhlYy90cmFuc2xhdG9yLmggYi9pbmNsdWRlL2V4ZWMvdHJhbnNsYXRvci5oCmluZGV4
IDEwNGU2ZDRmMzYxLi40ZTZlNDI0ZTdjZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9leGVjL3RyYW5z
bGF0b3IuaAorKysgYi9pbmNsdWRlL2V4ZWMvdHJhbnNsYXRvci5oCkBAIC0xNjgsOSArMTY4LDgg
QEAgYm9vbCB0cmFuc2xhdG9yX3VzZV9nb3RvX3RiKERpc2FzQ29udGV4dEJhc2UgKmRiLCB2YWRk
ciBkZXN0KTsKICAqIHRyYW5zbGF0b3JfaW9fc3RhcnQKICAqIEBkYjogRGlzYXNzZW1ibHkgY29u
dGV4dAogICoKLSAqIElmIGljb3VudCBpcyBlbmFibGVkLCBzZXQgY3B1LT5jYW5fZG9faW8sIGFk
anVzdCBkYi0+aXNfam1wIHRvCi0gKiBESVNBU19UT09fTUFOWSBpZiBpdCBpcyBzdGlsbCBESVNB
U19ORVhULCBhbmQgcmV0dXJuIHRydWUuCi0gKiBPdGhlcndpc2UgcmV0dXJuIGZhbHNlLgorICog
QWRqdXN0IGRiLT5pc19qbXAgdG8gRElTQVNfVE9PX01BTlkgaWYgaXQgaXMgc3RpbGwgRElTQVNf
TkVYVCBhbmQgcmV0dXJuCisgKiB0cnVlLiAgVGhlIGluc3RydWN0aW9uIHdpbGwgdGhlbiBiZSB0
aGUgbGFzdCBpbnN0cnVjdGlvbiBpbiB0aGUgVEIuCiAgKi8KIGJvb2wgdHJhbnNsYXRvcl9pb19z
dGFydChEaXNhc0NvbnRleHRCYXNlICpkYik7CiAKLS0gCjIuMzQuMQoK

