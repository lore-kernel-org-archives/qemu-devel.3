Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AE6FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMSg-0001CT-8q; Fri, 24 Apr 2026 15:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMSe-0001Bu-O0
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:45:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGMSb-0007XR-SE
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:45:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OGuY2c248003
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=R0pLFagtOXT3A1A52Kw0Oz
 9/2aOAtx9z5GsOo6XXsBc=; b=pkeQfFnICISxUI/FJMujbo7I//utDybsPYET0M
 iEcg+OIF7Ak+MNpZ3AyM4UgOEYZ4Ui/+5KoHGO1lVzwmLz5M2L1adtdBOQOQg8yF
 6f4c8kzU35NnCbsWx3L1ocycIu9kS4izx3XFrV9eSVkZvy8TxH4TuZDtW3Ub/7vf
 cKnUtzqHv7WCP5BYXZ2KJuvxhMa9gc9Vg3mVArQ+XG7K4nXCiM4ZbDR9tqtkuehz
 zXlmkGvAtj9CbXQrK2CFd0IJOp9LUna7Ofmlt4TFOWgK81RMAbUFpxqN03TxtJvr
 2C2JNQ+FtBluG7xO4GtuH3TbL9O3jhdr2o2KCL45KPz23pOA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqxbpc884-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:45:02 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12dbf4f678eso13934810c88.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777059901; x=1777664701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R0pLFagtOXT3A1A52Kw0Oz9/2aOAtx9z5GsOo6XXsBc=;
 b=a80GVanIxwnpP/pr5pZ0pFUKD43DhS1UFVQXII1Cx5HiXcQ18NBBndwlAHlHsoRIu4
 GqKsN4X9n3VHZLVEL6ksqLhpt1RcO4Onx1+WAy8MKWqot9qMVqfl0mGUXXZRX93QO+E6
 V99uyitPPD/qioZSP2aaQB8VecYYA0Ewuyk4TIJmvsFfMlYIF/sHgDyPZ0AQEqY62e3a
 KHXAdsyCPYU6dDyl+qvY4X+66Ftk2OmORH3pwJR4aGdGuBb93AMsLWfuxu6COGbyD/hL
 WuhBJqsG4cp7QPjKYTuJ5a6PlgHsxc0OQHihkZkzuSu43kVtaWbc4Z9BjrRcIz8LuKqX
 aLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777059901; x=1777664701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0pLFagtOXT3A1A52Kw0Oz9/2aOAtx9z5GsOo6XXsBc=;
 b=EeuNwan8su9hrhQDxeHTszprrnEOPgaG1X5sUIS98a4/PvhL6XEa0qFs/pEH3qFRKn
 4xCqQVO+zQSigZX942llIFR9lThOL65wefaWXnk+apcYsldwpDJHRJYEi00CamgqgMPm
 k8gOyHm+rpFfxJy8OaWSZ0FFeLG3sH8WKsbYPid+yHeJcqtkrcaPFb4XtT80iErDjq6k
 ZXgvM6nzWYX5g6C5D1isP15IQhAVzAjq5OMAwrGDWirWgWwLRSX8Mmoogrk2DSUaodeS
 oyjB7zANDtgXFTY4BGsjpTEqjDju55TUy0MW21LbKRbctL5fum5DCz6T4YtHaQTq0lwo
 YX6A==
X-Gm-Message-State: AOJu0YxuYiFwlD24EDkcRRbhfr53veCMTWW1iO/obHpY57dABJBOOtuv
 iHC/wHX+HfxCuEhK04BdPB34mor9EXiVBhdYhDRQ1YYnSvf/p1x03bSZRQdcbqB4FASjCaKQnVg
 8uc50XEORtoEhZECNbMSmxRmTAOVUugvIiW0NSSuN6vsSYb75A8eT8Q4yy3IZW+bJWg==
X-Gm-Gg: AeBDieuH4nKFqfBITmdkWUvTWW1NZDlyAuYVmr7utwOGXvk3ivxnzV8Hg+AMVdyOcLW
 97MQEeXtxh0GLidnafpyz4yJ0lfbMrL2SJ4KxWtPTZcPV+p/v7AXlSA/iWCObX+kCNsjR69d29x
 pknJu/pIsXx55cpt+FsL0gaJ/n/tE+Y0ypJt31EuThDUrQd3N1ctEflT83aRJvpjqqD+IscuYgL
 8hJr3QR3GMIQmtA04Zz+MIVY8MMKilA+EcNrNo/Zv/3Jd85aGzSOQOrbTwTpZo7X9+Fz63TAsmb
 icTD4j6sNYxik0K36IlZTjWOba72lvUD9qx/aKBh48AL7KCL8V+EjnZUYMba+nIsqW0LHlQ9zXn
 905gaEk+ZSlg/0jsNYrrUkdMZOdmKvpY/s7OEZXqWcVopLgZwsPqw5CZhxTRgyXXnSkHEVk//u7
 S6JinQiTurcYMfJnNc
X-Received: by 2002:a05:7022:ff45:b0:128:ca6f:adf2 with SMTP id
 a92af1059eb24-12c73fae276mr22400197c88.32.1777059900968; 
 Fri, 24 Apr 2026 12:45:00 -0700 (PDT)
X-Received: by 2002:a05:7022:ff45:b0:128:ca6f:adf2 with SMTP id
 a92af1059eb24-12c73fae276mr22400177c88.32.1777059900421; 
 Fri, 24 Apr 2026 12:45:00 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12dbe78e12fsm11385660c88.15.2026.04.24.12.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:45:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 0/2] contrib/plugins/uftrace_symbols.py: fix issues to
 extract symbol/srcline
Date: Fri, 24 Apr 2026 12:44:48 -0700
Message-ID: <20260424194451.1439316-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 02QYcR6IQPFHO31_JJGhC3GvgLLDlRTZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE5MiBTYWx0ZWRfX4RtQdrwYH1J1
 hRU2fFvQk+PPkzWilxl/EyFmARvJ3WH8aFegj/i4wPjP2VLtV04FRlxnj9Cf+XNGphCl+4X5YZY
 ac0SQ2iiTiDnezfwJebrZm7hUgwPTwNDWpLuKwVgqj4FWE2vxcZMlo4GhhaQHrwQk2jzN07ZX9K
 kZL1rMD+5daUpf3jfed9u+4i6f1Sd1W+S/UyheyScrk3TDCMXpceejchHcBWPYyrAMMvUhWKU+T
 WCVe4XXEdx1Ayll74UWgOiFYXPvNIPY+iBWCxwMmPlI2Pcc2Q+zAf708CeYV2ggRnt6vuL1rpix
 X9Ffn1GhEQQ2kvfmW7BQrtEtWCdXKZjILeYjI9xMCs9EssrbS1EzNFMD/PYv8DoQEje7xIaVUtM
 6ZXDtFa0c1GFcXUIdEuwFBErFNg8oMZ8GP2G9vTqmbbqPSh8wF7DINDcsL6lABKnODMU7a8Rr8z
 FBUe1BmEVjsB84aAEKA==
X-Proofpoint-ORIG-GUID: 02QYcR6IQPFHO31_JJGhC3GvgLLDlRTZ
X-Authority-Analysis: v=2.4 cv=X+li7mTe c=1 sm=1 tr=0 ts=69ebc83e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=5mPqyNZYKrVpO-mVLP8A:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240192
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

Testing this on hexagon binaries exposed issues with symbols having file but no
line information.

v2
--

- fix first patch to deal with the case nm returns more than 4 columns for a
  given symbol

Pierrick Bouvier (2):
  contrib/plugins/uftrace_symbols.py: fix symbols reading
  contrib/plugins/uftrace_symbols.py: handle missing source line from
    addr2line

 contrib/plugins/uftrace_symbols.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.43.0


