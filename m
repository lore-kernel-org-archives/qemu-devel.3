Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F97FC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcCV-0003fX-Ie; Sun, 16 Aug 2026 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCS-0003H8-Kr
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcCQ-0001gw-PN
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:51:00 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl1YD2760682
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ksRCWie5nZ4NE9GCWQvLL1FUkXlvgO++VzaE3tB9vN0=; b=QvY3SZdRyQMABYGa
 A4d9xuHkHArPuo+mXHWUExl7ABDiO0wxxIGc3axGi24466QYTcopJ7LY+3RrTlbi
 yyLKO7v3Ho3aVxr8B2ARM34LaXddeGGwI6GGwyAySGR6zKk3/LevPWhTlCOSj79V
 ivTtLXowi71EYeiOiRwaUG2OyeQ4Hs317AoBYcMWXMaugA48V3ngVZHvpW+y2s3N
 QAv06yR3PAmrQFiADeToRuxm/7MyMiSPx2+uIJn3q8dX37hYRTsdfS/eHL+8eRDd
 olEnz0/28IG1fpHRC2bU7W2qCwQnTdeqyDePg+kUy8Pl+f5s83dReRHPIreuWCrZ
 7c6vAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkh7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so29294001cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891856; x=1787496656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ksRCWie5nZ4NE9GCWQvLL1FUkXlvgO++VzaE3tB9vN0=;
 b=KxBlSTX4DLqKi+nNzvNp2hUqFC8kgO7I53pJNA2SQPlwy5f9bskV2LXDZd9Cbgjwpa
 Oc9UscvIohPFwf6sT1gdBAu+fZ7TPE7YhF2iiOadrZ8tdN81mmi7HuIWpHdYBqCe4YqE
 B7tknXWaQZuzy2aARUKc1SABo55yTGH0eQ1lkc8HK1LKPlndkCPn45GLCEjbJTNODZPK
 HgkrlfQ0OTfclAkn5ksj5nEi3km/pRE57tKj6p6q2E1ft69+3Tey4oU5f9gd3X7Pqa2x
 7uDsM8dzW/oOh/EENVfi5+h7CBFt8zGxj9TWR9/y9wCyZHCPp56c8q0kiTbcgkI5JxUY
 41Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891856; x=1787496656;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ksRCWie5nZ4NE9GCWQvLL1FUkXlvgO++VzaE3tB9vN0=;
 b=a/9xW6Bpqh0KuxNjFUGICI693lGm/uvyLLtfDE0sdaiHqN+oOdDTDtdg2c6nKQpkcn
 AE4EWlq9KyIex5N83A/BuJXW1ppFPa23zqm4OPl9luL7IL/KjlRsgvIOCz2vCui/GGr6
 6f7TnhHIS/7rPhTyUbl6/8vh34T7Ec3s2GwUlhOau26qxvhfIYVCnYy8kA5w8lQijylR
 HGbSlplCSugJIebe2BhS+uQ/oif2Dp4IKbNy298glq8xSx2CooPe0Zx5Y8q9zHugjOEA
 eTMYFsXWiBql47XL3pygcXx+pcGye7TA2KAzZLiVbwrnBnQ4FQiidEuobe6cS3JZuNhT
 cKng==
X-Gm-Message-State: AOJu0YyeEd56pbIbse+LcJ8xEjguKM5Q2c+27bnBUR35Spi+3/rWN3Xh
 abam9SF16xTVYfRJpRxUE2RkiuOce+LUWasBL6KIUrgJoOP4UkqOcN9Vw9032BdkxkSfYXsgqZU
 m3ipqVzbTQSm4dVGIIstJYR8id+E2tNfYd6az6oQu6l7IBHqXyHCKvhv+6nQnvmEq+Q==
X-Gm-Gg: AR+sD11aQXtUmnJvReYgtu1gQHGswqyyiuiD7nTqLDKLBIsMJlUw8zL+UuWolty5Ps8
 +g1jpD2y+1+1jTmVL0Jj5IqF4XgFM5jQq2o8DkmOECVxN8zIIb6ZNTGX/2mcTM6tl+/t9P1VPns
 Vikd7UdeuXv2kSEfX7re0jV9lvSfJs0+Zu+bQIyfKaZt6Zaa9AL+fWTNrlCgqlEgs1nOQH9ifbp
 xW0xko0c+knIq3RHIWx+CYLziEj7CdP3j3HeIyMPfrfAn5TErYgDWAup9cUYpn5ovz4X7GIHGfA
 CuGeG7gAw7vNTE03A9SaoA+9VJ9YdzObzor3qwb/rfSJ3h+fzGCwyIoIqUhzvIrt6LeoRoQbyZR
 aJQ40hhb9ybSnh0vAePevtj+GPFKK3lPrvyCx91JvNg==
X-Received: by 2002:a05:622a:190a:b0:528:f72:a986 with SMTP id
 d75a77b69052e-52d855b455cmr171072321cf.44.1786891856356; 
 Sun, 16 Aug 2026 07:50:56 -0700 (PDT)
X-Received: by 2002:a05:622a:190a:b0:528:f72:a986 with SMTP id
 d75a77b69052e-52d855b455cmr171072091cf.44.1786891855924; 
 Sun, 16 Aug 2026 07:50:55 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610e381sm72951905e9.9.2026.08.16.07.50.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:50:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/56] hw/nmi: Raise NMI line only once
Date: Sun, 16 Aug 2026 16:45:34 +0200
Message-ID: <20260816144556.69009-36-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: joM8z3aKvdlPh5_72CLGqlpcKlInkxrb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX+J5EAo/ZS7T2
 mXYlCa2vp1hOJW8c5ay91nT8VsIXp/5QoyYK4RKJ0ChUAH7CF8+9ZVR6pAUkDzyHPTG5MCjlPV4
 5fwJmnoZ2IejGb3ef7WBiTYPGduG8aM=
X-Proofpoint-GUID: joM8z3aKvdlPh5_72CLGqlpcKlInkxrb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX0gw1KPtkoO06
 8ydAtRR0pbZ5zn2tU3sihTkBUi0ixQoKILtxVMMUh0AswU46XdhdR8QPxPJiUVuIyTOivMqrSeh
 Ijco2Pm4tZWheKVIURhjoi51XE50NVhsXb6dlqbOeWC614MCPijEJxXmGwwPVc7KCinhPSSsYIs
 G0pL141v9e3en3m8WGQ4hQHN73jfYksz5Rmb6LKp0gPHno6nASoErzRIzP3Tt3vw3fxYSHuvFM/
 3CEfVt3qxqLKkg4vu00h9lv/VJzBuKYJtJuQzey6KOZlTC7Hbu7D41aQ5v3qCk0XMzWMP0S9Wni
 J3eLN/cCffQb2iQrhbjuahpGJCpZGMPq7Xvj9IIse9Km1bWr0BCRN0/3PP6t3xSnrHoPjYwG8Mh
 wSw+jGAmiy+4MGM03FpgXYK9eE9SChWvsvRESQLpweaDzfUDOghJClkHCN7cpG3T1vOXp3EdyfQ
 KafHvDl6EXbsDKI9Lww==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81ce51 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=HZQsDzxzLdBvz1sOA9cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We only expect one device in the system to implement the
TYPE_NMI interface (typically the machine, but in a few cases
for e.g. m68k and ppc this is an interrupt controller or
similar device); so we don't need to keep walking the whole
QOM tree once we've found it. As no machine type creates more
than one object implementing TYPE_NMI, this is not a behaviour
change.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812121232.71958-8-philmd@oss.qualcomm.com>
---
 hw/core/nmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index c44b0cf892d..84f21665987 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -31,6 +31,11 @@ static int do_nmi(Object *o, void *opaque)
     if (n) {
         *handled = true;
         NMI_GET_CLASS(n)->raise_nmi(n);
+        /*
+         * We expect only one object to implement TYPE_NMI, so once
+         * we've asked it to deliver the NMI we can stop looking.
+         */
+        return 1;
     }
 
     return 0;
-- 
2.53.0


