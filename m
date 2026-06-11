Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A34CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXyy-0007iq-C2; Thu, 11 Jun 2026 01:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyo-0007fu-6D
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyk-0000o5-JI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GLNU3724999
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=; b=RS
 ioFtRJpKFfxg+NmhNIUqWkfvZ4BiFNA0trXNiehFAylb+/8E+3ZojeLv3388uQIs
 yP4TzTf8eS98TOY0ZQjhsEjFUKq89KV8wm/r+ugmnDseIX/+UHQLre/a+tzN/UFo
 HsJYYdbO4LVT61Sa2Ni/RLYlx00XKx5Z1cdmE4VVaCsHL3D4cwuBojtVNq2LPdmD
 U3UJ4JjJr7YyNEKuK7us38HTCERqcBu6O/KT54iphygiJ+cviSwUXT6SjbxICne8
 TPtOcsHMdZu8c0dE9f8thgS2BGEwgTvAJkFL/N1NP0Uhv38uBuEfc0AMlPFehwA3
 uGqtm+8HWgx3PK2fOv7Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6v9qaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-307fe856724so1876460eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155761; x=1781760561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=U1sPX2RpjZrLYcay42X2CjriL2fq/+7RLxMl88L+owJ/1DMbzeeDVbAq+Q204tWmGR
 YlsCfLcFT8Hf6T5cmlH4cdp01GPcvk6W303w/nawVIzBfnz7H49SRfq37XhkKiUtWdNg
 VxasLMjQQETYM6V4ZXwfHN3tJgAmZyiS96bB2cYif6weE3BSuaDfa65Twf5qzP9VccfK
 A/lzu5BPLoLYjRiU7KQvxWyH/w7IEPoLY1kryYVAtyF1qZvyT7neD5rMk2WQ8HR8BhZI
 1JcMsIZFoW/GUTqVNiRZnNomNMaoHJ3k0DoIlMMne2S6itHp2qjUNeFoJ/fNMGoIZF1E
 JJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155761; x=1781760561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qd0MRjIIozbImbBr0lnxAdZmpDNRrMGNSs+reFaWXjE=;
 b=jC8UilVonrPmqJHKFiwKGdPUaO48K1t3pEsONfKWYrVEB/f62Yc4s/Fjk8K6dzjya5
 a0gHearQ7rScHREeFV1yO1/gFu5yUbk9uINsatVDucyPGfZSAlvBumHSFozUQg99an6O
 Pa/k8XfZW62z/vBL3pA5d6W6GbbRgHPzYrtfrGaGFzd7iBtbhHJHyPE3979yCU92QKaR
 melyqgOdf+9leTKd7B1qT8pI/LaqxMdgr+4F8te0pUOvC+PV1B3RdfgvOEt5QBltBicZ
 HRfFx2SY8KwGBMTnbhs3Xz5GCW35xsBdb5GTzEp21QWNINnF13NEerQVKJHg5tqr9XJN
 h+Eg==
X-Gm-Message-State: AOJu0YxJAbdAavnPEQydR3npKIdi69mcgetJL/1dlAC6WqLMqIdf+AsW
 Uoos/bwZKd4fn6oXCulIr0VjGwlWinKOYDK8J1zSUmHyIEoPdAND1xJuMJRV2J3ciJiYCgkT7tM
 TTki9qScC4p05Xy/IC6aPmQDTDXU93w0hqSM4OsJz0p26xrs1tB6FWHL6y9fzO1uWJQ==
X-Gm-Gg: Acq92OH5yKsd3MFU/jVQuiZfdpMhF6poDULSBtD+IBoouT5favJHFH/pSGfK5iy4zmW
 njv+xFswYu1+Aqa8nwI7i4XlC/Vr/bdpN0rCbNnwIXDv55UTovzh7WD4G7UQHoL7tw0txFDmTIJ
 imcVuKnMYMLIGRhZ7KHZ/w521zGMuh7WWzuvjQRxkceAbYo8RUiWsthFLKuYBWpU+lFZ4QQUpKb
 d2siSslrNB3/1r6b5sBDemK+igEGB5hT1BBUS0npp6b1lj4M7YHot4sigjVZ8S7AbILfDUmN1k0
 B4oIHHGfVOpzGvXNoqot3B4tuTvaXF7vwAaplq0XYxq7litEP278I1M1sceM/lpuVkJ79e0YT0I
 f175Nq3iscxjfttfnBudCl7SmJLAETwCIRa48ztLwkFEOSrIu640eCxE5Fhc0ukpm8uL9XHe+9S
 VqZP4g
X-Received: by 2002:a05:693c:37c5:b0:304:819f:502b with SMTP id
 5a478bee46e88-3080464dbf8mr1063387eec.9.1781155760590; 
 Wed, 10 Jun 2026 22:29:20 -0700 (PDT)
X-Received: by 2002:a05:693c:37c5:b0:304:819f:502b with SMTP id
 5a478bee46e88-3080464dbf8mr1063373eec.9.1781155760172; 
 Wed, 10 Jun 2026 22:29:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8] target/hexagon: Add a placeholder fp exception
Date: Wed, 10 Jun 2026 22:28:30 -0700
Message-Id: <20260611052857.3911981-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: hEJJdwQ_7XoX3CPXyxm1pOHj8A1HmWGx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX5lMz8Npbc7/+
 9yH8BR9kq7Y0wmtesLep7DAt09v9B2pwKUjMPlQaOa6SRmL9TUbi1lL8R0svTcb00Egblonw9Z7
 0fBsIWRKhHGMnBbjeBQInQRqlCUm2t4=
X-Proofpoint-GUID: hEJJdwQ_7XoX3CPXyxm1pOHj8A1HmWGx
X-Authority-Analysis: v=2.4 cv=UsRT8ewB c=1 sm=1 tr=0 ts=6a2a47b1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=R5LHHePp8dzqxDYlWrYA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX6GSNSwwMoavq
 ow97YGK/k9jMJU0FE3GB5s3FPkkkgayfOeJt/k878qpXjXHfLSmj/g1RxdvbJPdPX83+vWNnm+n
 /3YOcJmtUEDFZ4kKPjrjBcHpvjuZaZgo/8ueq+9d0XFcNPSObUympt6X5V3pWo5VLI9hcg3KgC8
 VnybB5E2VIQSMqrmT5NUzFzYXc7lK7HGM8ySfYIk4PLPKf4fdDCNSH1xKDmmtUPU01zWlKP8MfB
 t8pQzC0LR3zPY5Kd6XV4krM++65zIoDpKsrJQX7MBk0sOMJb1Z6c2ff9E0juNDsZcBhoUGcAF97
 osr6zHu1SCAnAMjFEjnCXbaYYSdvpJXpDFeUD+LJUm9h5/WpfkiCxLeu8aOHUIE+cxQMHeOfWNi
 T2wWURw+v6bjcDGh++VLVofSv0li0sPKGozaBBfCnCnJWMly3gyssxv4OHpzBRI/S62wcacMgZL
 uDtPEE2WLyom+X9umDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Fy
Y2guYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXgg
ZTE3ZTcxNGE2YWMuLjBhNDAwYmY3YTc3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNo
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMDgsNiArMjA4LDExIEBAIHZvaWQg
YXJjaF9mcG9wX3N0YXJ0KENQVUhleGFnb25TdGF0ZSAqZW52KQogICogbW9kZWwgaXQgaW4gcWVt
dSB1c2VyIG1vZGUuCiAgKi8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OICAgZG8ge30gd2hp
bGUgKDApCisjZWxzZQorIC8qCisgICogVG8gYmUgaW1wbGVtZW50ZWQuCisgICovCisjZGVmaW5l
IFJBSVNFX0ZQX0VYQ0VQVElPTiAgIGRvIHsgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsgfSB3aGls
ZSAoMCkKICNlbmRpZgogCiAjZGVmaW5lIFNPRlRGTE9BVF9URVNUX0ZMQUcoRkxBRywgTVlGLCBN
WUUpIFwKLS0gCjIuMzQuMQoK

