Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1667BC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtUJm-0001aY-3J; Mon, 10 Aug 2026 14:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtUJj-0001a7-Ua
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:01:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wtUJh-0008U4-Ql
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 14:01:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AGsCVU2237719
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 18:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vb/5X9c3Wcikkjw69SlPZ9cniY487iY8567MvQwVWT4=; b=HOSid8nsxclA6Pcs
 Y7EJL3aV8UJP/tSdgQvywDwa7FtAoRq45Zv5R0tmnQJAn/uHgBim54PTj//xSdfl
 /vKUUh1IwTqxFneXBeEluCxxZa2jPETurJ9MKaErhyAWye99m+VmRxptjkZAmNjR
 qgDpCsNrWS2ENak6qZCN55gv0U+ZAevViPuV2TC0A0t4VFsy3msa9i9cYUB5fyjk
 Gltjka37JeRbJ1ge/wuwS8ly56Xr9QooiFeDeOMBhWuUYqz4YkyC4fk0Pb3cPaZa
 P61c16AZ3fXTY2a4sqCbRVkVm6VlyDlfZk8QIsFUgmHITKfEpX4dZvm5mTP3zlmV
 IqDlXA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjtg9j9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 18:01:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso3555470a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 11:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786384899; x=1786989699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vb/5X9c3Wcikkjw69SlPZ9cniY487iY8567MvQwVWT4=;
 b=UdxXIx4vjx+NISQa3KHIj5K+SRO542O5bdnJMfLEk0SA/2HUItbudmnO5dv4RTpBJe
 +lKMLUdn/QiCW2LrOB+PrBKSHt11p17U8DP20a3VR+hcXZuuMlARETXfJ0SHpcaRTpxM
 7wlb9lBxJNFq1S7qorcyfvA+heNzmimsSM3VXLmX3iffm8R+8R+ZIssJHdPUNqifxvop
 V0xU4ZJLUtf0UxAP2nMA0k0W9UKhUCsfVDUres3sx7cxJWzMM9f97NXUuXdc+cA/0b+i
 lSsut2ubF7Co9demzwR5kbCEZ7kia2F1N+tyD3sND1ysLs2ceJa6V7SaKufFScF4t1Oc
 SMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786384899; x=1786989699;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vb/5X9c3Wcikkjw69SlPZ9cniY487iY8567MvQwVWT4=;
 b=eMaORPpwIhVgoDMc9cGee9sLGDgq9byXuXdGEoQyIN8rgChVyoQ/yCcRvmnUDCxfbL
 me/wyoxUzz5PYsdbQQhtjySmvWR4lNcTIgafq8OQmuB8uqNGPEj0W+LPcm6rH0zcGBAh
 Iablirb/+LXa20gvwbtoexLGYcbdxjupFLIk5XsxvQU+QBlrwsPW+t/OEeN+XSi4OVZv
 GIXlkVUm2XaoehrGtujue2J3wk54KApFLkpnl1RF2SItkeMeY5BZSOIPHMKlNCz4oaBi
 5srPLYIv/bwLQLZgs1d3p5BiHd7wWnUC7PYmRmTmsYHjEipMiSWNGYaeHUpMC2cqKj/y
 T8Tw==
X-Gm-Message-State: AOJu0YxtxXkdVGteayoDsPbJ6Z01KfGSjfsk/fhXuHpeuP5RoTOsDtHK
 uyZD5A8p7+SxMrA9fDwZQWfYTObWUEes9uIyilpxZqeelUnjxKNhZuLBd/Tl4aw4wkHOl2By3Fn
 PuxXjgIe9MylCtyNyc0CYhn0TU5Nh9wtTG/8Q3m+O9Q8UaaGaWGlwCf5MWSDlDrseyg==
X-Gm-Gg: AR+sD10K5aMfAcvAc0wese3zP6oGl5gmKGYCP+5zd33zGx8eV4TbMqBARg9Dv/nMCWj
 kCSUdA/7y0gJ/DkQ2Xfj4fS2MxqMWSl4QD/3yaQjy1eEvad28ROszH9OQaGD/yir1BJYSNLXbRR
 h+rBdTmU/ihv71eTyQgbSiWgaEd3gsghfX9tiT6CMhjobBwexgs917RhiR67dcUY/5hAUGTbZcm
 zVgVVAJ4ZVI1bo80JH5CEQeVTbzmU3fpBtA42TDaQ6pyyqV34tihC9wYpiglKEu5yXZxIUDG1hi
 RnZWzCcPjuCZr/7WOInhRqT08k4/E0+6t3M6MupKa5Q+/DqjkACUgrUyEF21JdcUwvc6NxFsJtd
 iY8fFnrj2ODJGJhCE3D/5LWt/4ZbUZYqLc2GRwaanu8yBYMX6TD070IPIsooZvRdsDWT7
X-Received: by 2002:a17:90b:28c3:b0:381:bc4c:da56 with SMTP id
 98e67ed59e1d1-3903c6128c6mr47883184a91.19.1786384899021; 
 Mon, 10 Aug 2026 11:01:39 -0700 (PDT)
X-Received: by 2002:a17:90b:28c3:b0:381:bc4c:da56 with SMTP id
 98e67ed59e1d1-3903c6128c6mr47883120a91.19.1786384898510; 
 Mon, 10 Aug 2026 11:01:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101a60867sm37264184c88.9.2026.08.10.11.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 11:01:37 -0700 (PDT)
Message-ID: <b92d9ee9-ad63-430c-bb75-ce1fc9a9df78@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 11:01:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <9e71b8cd-e739-455d-9b0d-e665f821351c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9e71b8cd-e739-455d-9b0d-e665f821351c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX4fWT+iD4FbC5
 krtfWg8TUoHhKhmwfTs9wCh5QmfO6QLG3uVdc1o0mIsSRWLyPbXlXvE/2iDX+v1Df1cSmP9xSWk
 54DvwYLEJeCsdCD6hqLHItzVJcrbf5sV/OuoGF/XX2CPHqIw98LcSxVn3Dp9QVmYWPM2XdN5gpz
 PDQehEx06fDSbqAuWBZ+YagTB3vn1/vswKWg+ZsYJptwKriGfCv4qcqRyf39xyUqKKf3bPUIzGH
 ELEUrPnkEa4t4tIfOEMtKHzFIaL7UC1bLf8ilc5oBOivJADpRhw0CHk7l89LQLhabL0tc1iNVDy
 uzIXh8YKuot3H56q8jxktiaRr6kZ8rgu9/y2xNbcqA9+VN0fhgmwBRtgXnwX5eZaZSPNqE/Jh+t
 1iaOvT9+weRLdvG56m+JKRb6u7MlTgUGnOCkPSQU5PREXDt2FW8iAxqoaHSIbzSwEhovXcHR0B2
 5fFenDDP/vZpjdbPdiQ==
X-Proofpoint-ORIG-GUID: QrBQ06jKaQT4DQvz1EehclxjNnirnNIf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1NCBTYWx0ZWRfX1JczTYb58xU5
 hCfdBbgjkhtW3zXxdhArcOXtDPcPlZPJVbkHK/en/BVklDpwgVEfXTI+v9OQvdxEaKlVntDQVHh
 yDQUcCkHtpurHgaFP9lK3uTPb0Ks8sk=
X-Proofpoint-GUID: QrBQ06jKaQT4DQvz1EehclxjNnirnNIf
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7a1204 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=0cT23l8WeYyRfqcthnQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100154
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

On 8/4/2026 2:40 PM, Pierrick Bouvier wrote:
> On 7/27/2026 9:41 PM, Pierrick Bouvier wrote:
> 
> Gentle ping after a week.
> 
> @Alex: the changes you requested on v5 are implemented in patches 96-103.
> 
> Regards,
> Pierrick

Ping 2.

Regards,
Pierrick

