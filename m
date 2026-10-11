Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FE6CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFwQq-0002mo-9U; Sun, 11 Oct 2026 12:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwQf-0002jE-7a
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:29:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwQd-0007CM-O6
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:29:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85Q683374789
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sS96VtZss0hen2JaJ0WQUnFCgNf1MhCxJp3byiu6LkE=; b=WZTd+g8ecbKwtrec
 to1xv2XjAia9C4hWxMfFn5i5NPixzL2tybtREkNDA649WV+tzt+RmeXYrbkl7j2n
 a4fk6If5l4AcoudRA6NPwNYT/m9OG73gvfy7Up/HBk9/BBA8WeAMfEH6x/Vjy/Gq
 LS+XGi+M0P9FYdc7qGDzyqBEF/VjQSTiDJepSxc8c3LFz7WkaehHeexXhk8HWSIN
 KkI3NXeJcuFJEdWVY/5xQ87FOLX6u33TTmGApr7Fv0oDRZwNNWNPEMTQhgjXArLk
 xIcRJbVtGa47vgw3ZVBnnlB7TkZKTJ9zlJmBg1TFJzFoq/i45huNwHW9+pptLDq5
 6bLREQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cc6bgs4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:29:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e8ba4757caso2432105ad.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791736177; x=1792340977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sS96VtZss0hen2JaJ0WQUnFCgNf1MhCxJp3byiu6LkE=;
 b=JbN3lvxFsFeuLM1j1TA7jSbvQVHUb7CIz0X/WvixzYb2mMi1XwEzlHZih3oo/gKRwx
 Rh1qaOmZ2dOTSp5nO9K9BCrCEoP5l6a6H8JHT19JabLWzuxwaKqfX6E2i7+PmmT9cBt6
 iU/nOnGQ/0hBpUv2wBiGO69vXriQo1kjzlDSiwfIds1BeGNx7bS1nBq5cLBQySCxpaXl
 hSJ8wFR7C1+2nujQ+NyKovdyBMBdvN/FHUoYdDy/6eSmfOVpg1CzvwNl+ArN1cTGulJd
 EHe2r/dq8SCjH+zClb6xvzYm0vGk/bpRroQ1E2ggNdHuFBLHQF9xXS7NATdedQRsK7bH
 /r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791736177; x=1792340977;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sS96VtZss0hen2JaJ0WQUnFCgNf1MhCxJp3byiu6LkE=;
 b=xWaT+eRQEJNoqjh8H2vF6H1pFDP+Q+Wjcb8EkYrY7GgQrlJ6lXJP22XPbvk/YPAlZn
 btG9R3WDqlw+HPTP1FdQ9EhqE95zUuW2LWyzKZ2X7jCrWBCwVn7GEzv467ZSP2U2i+jn
 3AvAxDR9FKV4Q8x7Bj+pPpG80cfxUMFPaTfaJKCQdzrPgoMX69TthE3JDzeS9a0wc60o
 oejxIn4xBFMmedyPNCyovtRtiIsMYS5L8IAmghwzdqdY8LFO0aq4bBqarFdHFQlVCyqA
 fv9OMlQixYV9kodSfhjwlhZj94Hd8dbVWLFJIAjbmXjWxo9ndfCHDeforVHOVqGz6XMT
 yUrA==
X-Gm-Message-State: AFq9FYJ1ul0+x5ObFAjeDow1EAQJs5BUjBbE636wLuU7ceOfgO8+JBU0
 CTnH2JANDz3E0TJG8uRltgo1Ka1Fd8+NWanXydI3UKixBp31xvXVI805v484uFIJnEuxev0Z7D0
 N9cdsTBRCR08vOBrSFChmMLNskuB+81E4KCFJ+IKrC2PnEIIsKK50X6A4n8dPPFPHhg==
X-Gm-Gg: AYBFou1n1v3iyR9VXrwZPuGtdk9sdP8u0gumZPY7wvQRUVaGPuriVXhqyICq+/ArRiC
 4yiK/QyY55xm1L0wwg0kfzl7Q1N5CFry3IwD8UOc+TpfQqXyiJpbtoPhB5PnMez8/tU6rSBkZi0
 /phpq02MEASm968DaM9ITogW3u6YlokmzXgy8/LTia82vB3rqJZofa1BQeoTNvt0g4+V0MA2k4v
 098JGVe+F5Yv0Ag+kefK7HFaB0+Hb1qgxLB6AjDXQHalhOqt8hy9ZHqIZU7axfLDo3iDg6YSRa8
 PMK8Td3LEUu/ucrc9nPtNNgDLXNyeNigtMohLEBF6U4dN8sK9SuWj1C8BWdExOHSlJfqcLYfCcB
 mgyPXKPRNl4NBTjmOhLx+fL1kuebXsSFulp74rnnMbbU49InDlR3oYHfW
X-Received: by 2002:a17:902:d2c8:b0:2e3:13dc:8dd1 with SMTP id
 d9443c01a7336-2e842ac4baemr42865485ad.7.1791736177425; 
 Sun, 11 Oct 2026 09:29:37 -0700 (PDT)
X-Received: by 2002:a17:902:d2c8:b0:2e3:13dc:8dd1 with SMTP id
 d9443c01a7336-2e842ac4baemr42865335ad.7.1791736176900; 
 Sun, 11 Oct 2026 09:29:36 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422fa91asm32696415ad.81.2026.10.11.09.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 09:29:36 -0700 (PDT)
Message-ID: <95643d0d-ac69-4b0b-a550-bf3095ec042c@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 09:29:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] releases: build and run any QEMU release easily!
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, mjt@tls.msk.ru, peterx@redhat.com
References: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xNh4DH1j8t_ZwyG-RMHPmRa0GsRp3X-p
X-Authority-Analysis: v=2.4 cv=XdQcX455 c=1 sm=1 tr=0 ts=6acbb972 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6VHuwe2FIH9IMXYC5M8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfX8b/laaIa3Ijq
 ojnrhzvcL2fON+PtJ6vMNbeV3s6x84lnRJTfU3ZTAfPguxbEr/XjCp0kQWXaLZkUWaHrU49vlJC
 O4T62Cpw4Afdn4bt7MV57dFPzHzp6e/bcID4TPzcE0RAx+tND4MYTXWdfUNbs46vCP0onWGj5DX
 I/OMRrxlR0X1XpeJjonH1XYo2EU8Ax+Veoe4vtnZ1iKUKSfrlEmB2yRX7yHFHzUwIadX0INYsoa
 TrcQX9+doU/UH6GHudHcywhbuQZeOVCWh9KP1JAmn7mXkJ1NTtfRc4AkB1GnvI9jiwW5CWhLlBn
 +qzzY/vg773i11mrObPr8gqZ/OiuVf8xylqg6LxTkOjoWaX1vZig97bfMvQj7tSYTD9C1JmFcnK
 D2fwYAs8bSuSuaJ9FudCktidESYQ+HrcUGyXPS4uiudYGuutXp/uQj+TC/yjFaYhsWYuLyEjAiv
 KtwQyppsEriMWhryxgw==
X-Proofpoint-ORIG-GUID: xNh4DH1j8t_ZwyG-RMHPmRa0GsRp3X-p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfXyycBpD6q55r5
 lxa7Cbwoo3F5F2/SwQkNG+Bfp6h1B+dk9YGjUijJQeeP075SFH5SoIGomEIMoPLABtJniUbSRfu
 K1tJ4q4aMsRWTFft6gafR8LuTfcaGjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Sent v2, fixing "permission denied" from release wrappers when accessing 
host files with podman:
https://lore.kernel.org/qemu-devel/20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick



