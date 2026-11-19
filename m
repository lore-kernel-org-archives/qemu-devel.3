Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81458606A33A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WbGbOIt1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UVKFCbtX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAJC-0003Ij-ST; Thu, 19 Nov 2026 17:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJA-0003Hr-Ns
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:08:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJ9-0006j8-7R
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:08:44 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1DkW3594970
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=nEWTAAfa30Ig6V13cvboEk
 fpgLWUCWgLhReYA+uMs4o=; b=WbGbOIt1cdjS1X6ziJKchW7bQLOdstfXbNFeLE
 k2EZBOGjrebIHgo1T1NrKddUjP0eQosoxE15fET2o7XRJY0WmrKtYiRiCOvZ33qO
 arzmCokl5VjV9OU9vdNRMKsuYpCjmgLd6XdyklKEYJVXJCYqwTsKqBTdUdfrnbWu
 ljXX2G0tloV1hZOdNhcXsgSo44thVB+lbbixmdtRFmq1sRa2dPvn4Z/ZACMt7XWL
 IEsMPtdzSOuu3g2o0dfvxw2isyfR2jAMx+vA6NaQ1HkMJBHf1gxVWNRIMHQLQoUS
 xEREEy5bLqI8jdzBawEZDfogErHeumIAE5gCWE3gKwm1kpzg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255whjn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:08:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495c71055bso62302085a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795126121; x=1795730921; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nEWTAAfa30Ig6V13cvboEkfpgLWUCWgLhReYA+uMs4o=;
 b=UVKFCbtXUYE/ioMofOf9y3G6mBnpgdRKKGZ9N1qUcZp3epvjPD4+dgz0EJkMP6VqjL
 0eHhXZhlX0k6tTLsU5Lt6e2MobpD+Kbki/o5gzdh1UvEDkSfhpCQjPoyA8Ct7TkIl0T4
 BAU1jaVLGPUg+v/1dQ91fOiGHAY8cBrRTzsGsdkAKE7zF7q5eMNK+dPDLgxSDDDWyaDI
 u8ZbW1vpqdMM1g7yIfoakRx6NfU0KL/uvUorlTkqbhglLzcFjvkWMDh68cwkGtAsgKUk
 kKTCcSmC2Q8fRH4VsKoOMETC5mVs+JsAMUCqZL/n4X1ehbeUc4lDWB2ekjz7ICgd+I0F
 OQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126121; x=1795730921;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nEWTAAfa30Ig6V13cvboEkfpgLWUCWgLhReYA+uMs4o=;
 b=PFphb6ZHPYSwLVeDukN88hfMteN7E5Idqwh+Rquv8drWeeKlJXA4aNR30OrH1T+oP1
 j9ppdb/78JsGhj5SIGPpYy9Stc1VYW9CdSIoFsBkpyXAcoVpc9crGTWg5PPs0QXI1Eun
 F8aOO4i4aI4DXktqWhzF2W7Kb3tu5KjyzU5eDVwx0D2wxoi95s+EEYjO3jOStvzNOK5d
 Pb4TKYWJ3gazmYlp6vaip35oUYToG6ancbAmcR7Jo05ytbD89PfQPxCtXJs+lI1Xts/0
 TyaD/ygmiI24tSuNUUPfT0UEHYhTltLVW+pl35ldo2zycnDr7CqltUtG7m1XC8j4z1pi
 9C9Q==
X-Gm-Message-State: APuU4Z/zlgQdndzPEC3Oh7YfYyXy7XGOu9WKYbjCGRNrxbj7x+unzkYg
 USS14PY+Bpbz0J/4fQj5GcYkQKu3BADOA7sM5bPN2Rit3OZ8JA4z540nC7LuXRI35ZrjyjYE1Vf
 REtiQnwiKCqRKlChttW1pZpO7FWCe3o4uTLAiqsRtpXHQ1MmMDiFW1M75jGzsez0kNyNi
X-Gm-Gg: AYBFou01hfZ4vCk8Jz3rBGOIFfKA4rTf506QcmOhskx081seRB8utkozBeaXUYOERju
 9546IE5I+6bBn1YF7tySmzDWpZDvFL2EJ7BmND4TQj6oJ3wkumH6vL7Ca6riWeObKfdoR1roUoV
 6EIePr304+QQbLWIE3uL0UXDKT90baW7yBbDoerT96qh3q4GtMAtiorCqisDxecF9rD8+UxTNqu
 bJsNsjMzFg3AsowlRSgS5Dti+cTD9+JpZhPSAF1ekx0FEpermIWiliqwMyXPRJtYJp/stF/tYYF
 YjqZUNHCYttJGqvz2/vNGaaMFq3AclqcUFOEXvTgbETDZAZlX91D74IqjQTrj3zu9csPMCRccq6
 r3X/Ib/IzF+923+1M44DQLz3czd/ln0E4xvtd22M6TZLmAWZGfKxniUfyrxD5lg9MEjuKInhrXy
 dBBQpdet+FfRGzsg==
X-Received: by 2002:a05:620a:4628:b0:949:8acb:5df5 with SMTP id
 af79cd13be357-949ba9ffe09mr184107685a.37.1795126120669; 
 Thu, 19 Nov 2026 14:08:40 -0800 (PST)
X-Received: by 2002:a05:620a:4628:b0:949:8acb:5df5 with SMTP id
 af79cd13be357-949ba9ffe09mr184103485a.37.1795126120272; 
 Thu, 19 Nov 2026 14:08:40 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm29227475e9.7.2026.11.19.14.08.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:08:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PATCH 0/3] hw/dma/i8257: 3 trivial fixes
Date: Thu, 19 Nov 2026 23:08:34 +0100
Message-ID: <20261119220838.52034-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX77ZBU540YCQn
 /cLme2eTdBg7tHGTP2IwOpwT453R2l78+v2Rs0OY5TIybImAFZDW4OgHO9+5ZFCJg7wR8KhoPwE
 UPH0exoCeEfAClErgQTl3+9iklL4Hy8=
X-Proofpoint-GUID: HEIbBnHOMM2yMSa6n-TFXY5yxCuJMHx1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX91bz9+M9TAUZ
 c6YrVX2PFFKvq+yVpSwsV94tkw0xSb/fpoDfwAp5pAjwnHNopESxg+i+K++8rBZMCsoapWXigTN
 T9gE0O7lTbaY+n1XfEjKUlEDKyNmZ/eNspoV7hJbZK+T7q8UVprdheWrtUFz/7YdZB6xcCgJqZ5
 6hNNRVQIKDDldj79HObZTxtU32JqXgrx2VRLBMRiO24WpP28Q51jzIHTLDxysLUhVclJVPrfmmF
 6+iF2RGqwgeZdzFSxw6lS6Dw+UxoaDy4epXRwjkVgysGGyBVJTkqqO3ucOz5sKz5dsTQ3/PmRLK
 Zvl1NPdvOKMsBXLwBph8LWFxCwaUr/McPrx8daqwT1rgihSLffBKW++JlIn6T5tDirWXPDRs24e
 mFqXeN8Q/VKMjVMjtjrQdEgQ6LPg03YGLghm3Dr0rsSngHusYv7/YNmxTNbJ9JLOc0o1IP1gIj5
 pNtCV3hybeMNWIPB6jQ==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6aff7369 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=4RAH2LTXIgW29PtErd0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: HEIbBnHOMM2yMSa6n-TFXY5yxCuJMHx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190089
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Trivial fixes related to the 8257 DMAC integrated in
the PIIX southbridge, helping with sound on Malta board.

Philippe Mathieu-Daudé (3):
  hw/dma/i8257: Read the mask from the RWAMB port
  hw/dma/i8257: Zero the reserved bits of the mask register
  hw/dma/i8257: Honor the command register group-disable bit

 hw/dma/i8257.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.55.0


