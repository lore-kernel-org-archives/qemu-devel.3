Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E157606A682
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BmOtjw0A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NJLEIA54
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl3B-0007zH-Rr; Tue, 24 Nov 2026 02:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl32-0007wV-FD
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl30-0005SB-8v
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:39 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO5mTTw4136535
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l6b9NJPAUtONjfMnMVJk30eC5FlCprNpVFGc9lfeKJY=; b=BmOtjw0AJLolu11D
 G6vx1beU0A7+qz2Gr1vFuhf84d68dfjJNuWAD+SDfecUYyjscsM8e49xFzJ8w0Du
 6UryxHcvdyTmNwPYZkiDECvkrx9fn6k5m4K+uiZVRWDzjwpfzOmGEyPvyzWFQM1/
 SOPR0zjWUbDKtw6Lx/FvhRWglDU4gCsII9/RKjPG3f6nZEDDQeociIuC8Dc5Ss9G
 1pggpHylCeDajIUyQ4+tueM4EMveiPUHTiCRx7/DTe8bmb+n2jlpR5V+pr2Hk4Wp
 MPaBuIFusp7ivETzABtJBr7Fex8GeV2YTRInvdFC1OYA9clSZCfYkDQJS+J+sHhW
 7h2aWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rpgcmr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94961511b61so707070385a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795505677; x=1796110477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l6b9NJPAUtONjfMnMVJk30eC5FlCprNpVFGc9lfeKJY=;
 b=NJLEIA54mqAc4Y+E6FxxAyI/MyOyTG9EvzRY6CRyRrGTe5pNicSva4e3g49i73oT25
 vw4e8YPuyOvXkJt7G5qGSH9Qy5IW60vq00xs3LodWsvTVKMGRJitocu163KOqbYt0ZrP
 04fdHUdRN/GeixqgI5p48tP5KAlPwhoL40tKQQeBoxi/lJ4EaiyfYn6VbjZXYFTyVQ+F
 1RsGhEeuksJKmrxKifCrxuJN4Dkm9uumCoejsNiA07YhS1DH6sxzyjYKDgzzkfjU29rR
 IzE+2avKausleO5po/QY4w+XY460gvyufRqanU8Jk5W8QDQd+h5tvAEZfuS54miOZeQZ
 FnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795505677; x=1796110477;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l6b9NJPAUtONjfMnMVJk30eC5FlCprNpVFGc9lfeKJY=;
 b=yPi3Zr1ys8VexTZLFQMN1fl/TI4eVOuRCwmSek4lctKjqVyCrJ0ozZmKkaYXX2z47q
 UDA8vlm/46aTnklBbi0Hf2PYlrZ1X4yQHd564YvbnpI3gRxD3D2TIhbBq0UNbhk7Lqyz
 kir15/grw4YjmlZNMW5+A/XTMhW3DZJBGQEoqgK+tcb9DwHdIs4QUTA1WfmerjkD7diV
 vt7ho/ZGWOBozwOIHwELc8q3gzOhf31Pnlpfmh/Eabe3gRyF/xr+kPswNgOA87TRcQG2
 Ogp2pdl9f8NM64qUw1IKlZZiU1pdSZkP/5RSTsaNgrMZsRsIEcLA4bPnNnswPM12LgUw
 4rew==
X-Gm-Message-State: APuU4Z9hQbikCYytPZdMrgq3Dof0uJur6K264P20nuCdJzH1tnqy2PQ5
 OkQd/VsJeAeR6H+cQ/S7DhUV1Z7kitx5nLTSDAKmd8/x4xBHmyAXqwVec7eF9KmrjlJ0F+uuad5
 ka2fwXgSSueytdrQwsh57K+E29RQ8kcd7rlOQp9Ld5Tz7umNRvol3Fv9iFtDR5uXD89b+
X-Gm-Gg: AZFdTZeEA8KydF5DAUHRQe4DiP05IOYRMsif9V4HhLJrwrQIyVNB7isTPSndHdqB2Ve
 jEtJv/FSUVmmCPCJJo8Spc4qIbc7L5aMmusnM3ns3byl7BV3LSJ2br1tC+P/77B+NwtmiTTW8WV
 xwgi786s8xLF5nH5o1BpKNGgmNY+ArjUv/eV+zKRY85lPLLHKWZWYCDfqbfrL4R++CCaBND0TLL
 O98NBwGrwsVXvJZ6P340oA2BzZImO1+JGo5MKPZwYJ12znqrZoT/+WUv5SqN+2wlP6KAc4XuPe5
 zOoTm81A/ZuFqLM0h/cgDj2+Vt3WnTrI3nDaaRZ/DHCYNDW7YRR4J9yADwabfbIvgj03Yxj7emK
 3clY/ILl7yR4vzCITlNzwFme01X0rMZatilFpf6HxKFklBURaipAHuh9IOezVINkYZmAviEqSWj
 dQ7bQd2rjkPg8e8A==
X-Received: by 2002:a05:620a:6493:b0:914:afc1:c66d with SMTP id
 af79cd13be357-949ba7cb3damr2287269685a.11.1795505676770; 
 Mon, 23 Nov 2026 23:34:36 -0800 (PST)
X-Received: by 2002:a05:620a:6493:b0:914:afc1:c66d with SMTP id
 af79cd13be357-949ba7cb3damr2287268285a.11.1795505676321; 
 Mon, 23 Nov 2026 23:34:36 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm372042605e9.8.2026.11.23.23.34.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 23:34:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH-for-11.2 4/4] hw/sd/sdhci: Gate Auto CMD12 error status on its
 enable
Date: Tue, 24 Nov 2026 08:34:05 +0100
Message-ID: <20261124073406.87537-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124073406.87537-1-philmd@oss.qualcomm.com>
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfX81JD4aePHNM4
 E0TIcJVjyTJap5sHrznibiCz5Pw50b6TkQuVM6VlTRCskVthj8i4LwaAFm0wZtJ5e5kchpAwd4L
 QRYYkhW9/a1gO9ttGxGJcWY341hfmj7cbXgZIq2IFCyk/awXLaPsqgTOmBaAhCZnKz8oWv/Mr10
 kVftYde1oVysiMZC9O1iIx6CHaD0Zet7TV/MW8cHrUw/sSM/2jsGGyEQsnf77YkVBL8hxM3h+Tu
 usb28Ds3u4UuMXcH42Gt1ZBxcrvGuWfvUszubEarRwhE7jkrAXsXbDAYS2+MxAr++1pjbdU4qGt
 upV5cbHH1+jw0dCyyB6RSfCPIvMPEO60ck9ss1KaVPs3UsH2Muugjd8JM3kmRV1QyTFoh5VAFdr
 rw3Ea54KFrnAujqJlex3zDmcYMz801Gr0XuCOLHWAPPGAdIvtsUR9XqL41IIEtbIMxukNmieLb4
 QbJLZvZ4JSYt+oSCjRg==
X-Proofpoint-GUID: IkWsqUIodajl88Rlz9q2O7Kgqq9V68SJ
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b053e0d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mV4CySlLxiwW7xibkvoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfXxIEnBJhGcboG
 1vHE48190UwzcXYvhYfln6stGyG25EqsQziGTPZPspw2WBkG8njJVJyTfGXiuSre9Dy5bhYeJes
 6MXViIfJDUhhJPIyEW1ZeHb6m1HsnQ0=
X-Proofpoint-ORIG-GUID: IkWsqUIodajl88Rlz9q2O7Kgqq9V68SJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The Force Event write for Auto CMD12 Error Status (also reached from
the Error Interrupt Force Event register) set the Error Interrupt
Auto CMD12 bit regardless of the Auto CMD12 Error Status Enable.

Gate it on the enable, as the command-timeout path does.

Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 9bdc898e7f54..f33e2cec9b3e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1442,7 +1442,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     case SDHC_FEAER:
         s->acmd12errsts |= value;
         s->errintsts |= (value >> 16) & s->errintstsen;
-        if (s->acmd12errsts) {
+        if (s->acmd12errsts && (s->errintstsen & SDHC_EISEN_CMD12ERR)) {
             s->errintsts |= SDHC_EIS_CMD12ERR;
         }
         if (s->errintsts) {
-- 
2.55.0


