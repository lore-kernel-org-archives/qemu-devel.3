Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fkgb8UhL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fDCaFKnR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl2r-0007q8-7M; Tue, 24 Nov 2026 02:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2p-0007kK-4o
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:27 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2n-0005QS-As
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:26 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2kBhQ902444
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wbw8TWho3wNArRRVsmiVOXwI6gIVJAWdrSmx0gCFzJM=; b=fkgb8UhLiFGeermT
 wUIGye8BwUwQ1jeGtJD8x/YXaybX6ewLrHvd1rGNRR1WP3127z+hy7IC35+FcCx5
 RYi1hAFDVWC+YKaHVXrGY+msWz0rcQCN3mEo9hT/48XIHfXF3maKrvQUGDoVuCXe
 mbrwzfvdm9VYOraymvoAeQdlv4GL7yjKMnPs2gFf/Re7U6I0zi6m5R0HGEfIGwWp
 ah11tUX5wuv3eebvNjyYEH8zHxZge3YgrVJxpSNf7+9zpVGEIv9dJhft7GX0XoSB
 /3BLsPPnanDceTbrtzrCWS+oUeaeGub3GMK447eYlijQXkOGaOk1rHb0BuDHssL3
 ZRg/2g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6st0uv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9212d968d19so78366926d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795505663; x=1796110463; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wbw8TWho3wNArRRVsmiVOXwI6gIVJAWdrSmx0gCFzJM=;
 b=fDCaFKnRKJrpiOXkJi8CWcBljv2V+abdVyUSINEbHFSNZ0sCNKV50/PgWomHNDsDCA
 ods7eBgmW/8ctzyFC4YvSCSTDrEahyvFThI95rdVhpyiKX+edwIN2ISXKxbLFo/1ujM+
 E5ZxB5ddZPkV0eFTDF3nCvC17mo3saViLUX9bYbufssJB6EEOG9z3iW8KCX6bufUAfwp
 bc9WzfwYMY1W6FDhnXvoY3AHwhZt9YvJvT2Aj+4Ug9UN7G3LCty5Ullr9iEjnHzoAu6x
 Jhwfhuck+ZFwAJKK5GPW5fWBkYd7FN3B1zZ4NqhPzxkKPKFthbb4kNo3MoKr0G5rlM5Q
 S/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795505663; x=1796110463;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wbw8TWho3wNArRRVsmiVOXwI6gIVJAWdrSmx0gCFzJM=;
 b=gmKWM7YbEW67+4GshHzNQudpK7PTg0vv0+OrUixiUVttTRn2auW2fWWtxaXQwYExiG
 W03nsj9gCg505RvmE//0iSE8GnITid6CK8apG3xRc4YqJtxbkfoCRgx1a8Vq4MfSsznU
 mniB/x6orVvakY6SVhRnZ2imWLkEj2A5IPLuHoxJefh379nsXBNFtXjLZdAK3F9Xrmky
 bzqOEZbmO9cg0LOjRg9IMw0zztUuPYjwU9dPM09tbyt8N8pa9WDm1tUiQtm3Zr6YC8nc
 D+rN5KrZ4iU2ieCztcuzjZ3jEEn0P1HAGXFZTBXq69EGrkWQlDFYdzrzAGAktBsTtwCa
 TeBw==
X-Gm-Message-State: APuU4Z9nQVxNBalXCvL0ELFIEYKr2N91a1fB8zIWqGCzyhSfheGRaLTU
 7sw4z6x6DZOnpknSpypcKEed7HoNlF862Pm/7LVry8uhhe/QgVecP9safsBeVwlQ2i5NZc/WduB
 McnlCW+sUfflMMD1mUa7HQFYGb66EltTEi35DMXgSMbvpPks4KiYTkKeXUIH6YnlxWjsV
X-Gm-Gg: AZFdTZfTz9IF2GW3dm1xP4NFiKAJ8cj5BREdUEz9th1zlmTlyPhl7u7D2LiwnUHnOmD
 5xzssfMiH0OYhLmwLNgvX+rf90FVVyGsDzoE7qzJhUP+kYVO73OM2bHqVQ945hL/fhCwVQiXsV6
 q2C5PaN0E0otRjOGBxmL1+/qQ3vad52gA4ePCm94AAMkZfKxhwhwwKPcZdxndEpwZcvIU41wjdv
 31manfB7PowKJFEbSxVhaNanUepiKmQIPr/OHh9chd+eWBE9TiEkjKqGGpCGnGJBF/4bwi/WSSg
 4rCDtqGrIP4T7FOwcHF417g9XzH37qJR1b2xHpzJiQ9A61bW1sXCMB7PFAAKAK+OInCZ79vn3UY
 UvOnQkAxilf6H0OhJ1/ZTv0beFNRy4K5nJd1CTh5aqEI4KU/V6CfDGKm0Tfud63cHU9o2FEoVKQ
 ndsC4II6VM9xl3rQ==
X-Received: by 2002:a05:620a:6603:b0:949:8d0d:6f66 with SMTP id
 af79cd13be357-949baa15529mr2026659585a.68.1795505662831; 
 Mon, 23 Nov 2026 23:34:22 -0800 (PST)
X-Received: by 2002:a05:620a:6603:b0:949:8d0d:6f66 with SMTP id
 af79cd13be357-949baa15529mr2026656885a.68.1795505662400; 
 Mon, 23 Nov 2026 23:34:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm767777045e9.4.2026.11.23.23.34.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 23:34:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH-for-11.2 2/4] hw/sd/sdhci: Cancel queued DMA progression on
 DAT reset
Date: Tue, 24 Nov 2026 08:34:03 +0100
Message-ID: <20261124073406.87537-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124073406.87537-1-philmd@oss.qualcomm.com>
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: slKyzwiWc4AIKfzGMb2cB50IPBWSKlF7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfX93rgQgbtP7Ui
 0rsfIa5gwcy7O+oYCiIAKZWGuwe3F+1Q3bGYzhu41d+KvI7d5wuMNevNnc5UJ5Z5JyHHDt0VEOr
 /FnvX9IhSJo69EQf6v/hRe9qEAb8O3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfXxUaDgejFlMw7
 sFHxVikAb1zXVz/yrt9nQL0SnA7o8RqFVcCMMejaZS4juvYfkvrIm4rDuVvx6Z53XrBaJKfgQA0
 oeOcGgy9MTbLhCsRzq0nGn6TBVCz2Shg09w1cFDWMNOkzXS8UuXHSfoVZm9PyRxT2RUw5+P6Ojl
 bJC/NHzkdYWiEUZixGWgzeLqz4zaBOCCCf0hcsAGzxNaLVQyFOTzjVIY/nSgmKxkpVZboYI5HEV
 J959A7e2P7Heir996ADVWagQ6CFsicMR0oYbm1m7aerCXBMyDpbXvL3499lI5OMeVXOEZ4LCr0n
 dp97ZGaD8WD+8x5TfH7iracnmWa9R3eEAD0Cp84wCho6Z+ZQWzK8my2UzNSDBYKm3DijOaRajcC
 okKrobq1K8AJTg5G3E4DQs5kCEQW7q5Y7pOzzc86qEvIctgLcK51zvqYqztKnNis/Js/6v+9XxQ
 PviiKkeQMPpUdJK7vDA==
X-Proofpoint-ORIG-GUID: slKyzwiWc4AIKfzGMb2cB50IPBWSKlF7
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b053dff cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=X3tlmgJnzRAimXNpWgAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A DAT reset left the transfer timer armed, so the queued DMA
continuation restored DAT Line Active after the reset.

Cancel the timer on DAT reset. Software Reset For DAT Line aborts
DMA transfers (SD Host Controller v1.00, sections 1.5, 2.2.16).

Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1e70e1e7dd52..695de6448f89 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1246,6 +1246,7 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
         s->norintsts &= ~SDHC_NIS_CMDCMP;
         break;
     case SDHC_RESET_DATA:
+        timer_del(s->transfer_timer);
         s->data_count = 0;
         s->prnsts &= ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
                 SDHC_DOING_READ | SDHC_DOING_WRITE |
-- 
2.55.0


