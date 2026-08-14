Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A40C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wukw7-0001rc-Oq; Fri, 14 Aug 2026 01:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukw0-0001pb-Kj
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:58:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukvw-00050Z-VK
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:58:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4Qkpb308311
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KnFFQqkGI4XvAaq2e5N7tSGoQVWyfWiwdrlReHyet+c=; b=DisI0mq+6urzuPC6
 uohqhaIQTrXbGuLKOWZWth8e7G3Mow0k8l3B0ffA+6JwqXV5k8EyJT0w5EZ9E+qM
 PqgOQoJxhqBDOyJHx3kh0gVbiCB+XGJi85PMXkxTHc+Iy10BWybJ4/6nO/Kle4kd
 rva4pb5HsumEHpefpv0hNcsAJe+botykUqge4D5Wb6b4YpfcpPRG2PAbAFclsCwM
 txPlbKKxdlpZL3v5KZP7Sow45YCFUdC3XAT6WUnXK7t91/EUNUVrxs2djRPPzZh1
 uZWgN0cUD8i4+aV4EoDEaDLWdMo4eve7PCwwQNPAVr+g9Srq/Z/0d0sDnU6ncLkh
 tI7XAQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2f2k3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:58:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9309af14fd7so60112185a.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 22:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786687102; x=1787291902; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KnFFQqkGI4XvAaq2e5N7tSGoQVWyfWiwdrlReHyet+c=;
 b=g7qH11T1NSMhLoFOXAuWsHt/PyFS1GgEeJezBQF69+No8L7z422GSo5uL2oaoUKNNQ
 v/Ay9udaVbpwIOTCGRE07g13ZFlf3XLdiyCqRQ/Y8yBVwCNn4BNXPJb58ytNSm0zN+AD
 S/WP58qS6Xu0MJlm3ePQEQWlnbCZDJsd5A/Vfd2hYRWfnHpR1/cxPyHgszwD1kiQGSj+
 JUK6TI6VP15P/cULdE1PXgcl5OutRlYWAW+5U9HNWnGgBZXKovMgbbufm+J0jHHprYaa
 BysHC6gw2tUsf5HjHzMdkf8mdVDP8GkyXNiPDF3t0L/2v2sP54p3/Glwwa1BSxWQQxW9
 HloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786687102; x=1787291902;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KnFFQqkGI4XvAaq2e5N7tSGoQVWyfWiwdrlReHyet+c=;
 b=KuiZkA00yVDnwNbpdBgPSfnZu5IQbqPuvE+VRGqE/7geO3iXNjCefLcvHTqmZ1BGHJ
 KIXUCUAdalGrvDqMq5VxsbfJ69rPrfaGjmJa4qlBB1NO9sta7dtXkP0xKL/jfjKNfE85
 z9Civx1sRbjOsYTZVVkZgPIzDWnyIGFglIvNNFqz5XaH/Fyhmmq52i+aN2sme2YFzGjU
 Am4EeBXv43C/HwKa81yJkrGGLox1a5yVM9KnLh++TKvO1MibygIy9YboY4WKa3vOROpj
 OxID3WxB1ydk2+VFMdsh7Nfj9CjsuEC2NaSYNN6ayUrfTdm/yUllcHeLQBWa8uUfepa5
 6NTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjzUDn5lU6mWubgXjhwW2IMLwTf24edKg06GdkTMjQRw97evEVe2QqE3yAR1MqPgTfiXOLLpwG4opW@nongnu.org
X-Gm-Message-State: AOJu0YxrWCw2AT0M74T8ZMZVTUGptaOm2kUeI/t73B7q5q7qXVwiad3M
 REwOVx4uQERLtyfxmiHORUilZGvPWz31pcmn7M9tKMPmfKsjfBopjYxk5L7Q9Y22Mkjl8RzRAid
 BHqmmF4Ge3HEywLP0R/c3Vmy7C50453UK0GBraLHq+3slbn9HP4TV9kDsxA==
X-Gm-Gg: AR+sD130i1K4obXI2q+JPLsTHxX5l0t3JyuDZo9yBrUAUweSuYHtMQBURtgQ7xjRXus
 ETP6RgzGyhhbxLQmEawhCz5YhEKMbl0x6s8om/dLrh3t5t4tzosCg2sERc/0bV8gG9/I6xVbSIE
 aP4uu/AM4gWf3TVax4EmPo1RTPVzuqyhhazD6dy1WpLXzY/y8k86zKxRHaWwHaGV47b6tThJ8gG
 NRVfNp/epi8liyUOCBHNp8s06+uwWoPBhlt7R/p95M7ktfP3f1vKeLtZDlTwbN5bobzydAbfoXG
 zM47r8kO69kMvWz6v/zdu9Ye8zFc9dmvfLN3fbyGyjvfjRfkU4mK/Yddx3x86u7H/1Yu32gav2N
 WuSDXqQyiVGT0s4xrs5dzJo5CnSUrf/b2sJQ=
X-Received: by 2002:a05:622a:15c5:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-52d855014bamr36998101cf.26.1786687102296; 
 Thu, 13 Aug 2026 22:58:22 -0700 (PDT)
X-Received: by 2002:a05:622a:15c5:b0:51c:2022:cef5 with SMTP id
 d75a77b69052e-52d855014bamr36997751cf.26.1786687101882; 
 Thu, 13 Aug 2026 22:58:21 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49989af26eesm919055e9.15.2026.08.13.22.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 22:58:21 -0700 (PDT)
Message-ID: <e3f42f40-7cb0-489b-9cb8-6181317b1f16@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 07:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] hw/arm: Store the ARM boot info in the machine state
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goat?= =?UTF-8?Q?er?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Troy Lee <leetroy@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 qemu-arm@nongnu.org
References: <20260813154918.996812-1-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260813154918.996812-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FeMHAp+6 c=1 sm=1 tr=0 ts=6a7eae7f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NUi-4xgm_u2QagYK-hgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: vKnriFvSTAiuY7PC4syht_gv1JqD98iL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0NCBTYWx0ZWRfX/tyDLj+nZnKg
 PC4nPqScuATqn0sjSkoCPH6XMaZDB0EzLlqnXC4U/NCnuDQYXFeGp0RrNBkg/KlmzKxQ3ryXE6h
 9Kq2p78rIBq6Riq8GYuLkNwUMI496JOP2QksGCM8zS7faJl2TkmYqJMPGFFPibpS6wh2bUEwMtx
 BuMTjx/6oMyHxUSaNkLgeIQ8U2jkgukn4WRwmPH2ct0kL7VjKD+z8oMvfZnsXKMXOG6zwm6bNhW
 kmZB8fpmn/HJkvTKpaPXWGI8Mx5Bhl66XTRfAT2pb9Wh2A6HyaIBQMX5FV/S2j9HEglGZ3rlYH+
 ilWZDrnyCM9Mc8p4xRfwBcEZBVNkSrDh3g9NJb+kapMRv0LCE8z7KUO8EFZ4Cdx3F/dGrgTHykR
 jHO5VfIpPETtIAKl7F5IzfDrXM5DAot7XICOGjSs5D850Gj6P+k3NA0Absbd5cdan8BIcSjefiG
 IfHumO/04N6VTjL24wA==
X-Proofpoint-ORIG-GUID: vKnriFvSTAiuY7PC4syht_gv1JqD98iL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0NCBTYWx0ZWRfXxcdXFcYEOjwA
 5ngxpOBZCX79IcA1ivIdMybLVunVqBliPmMF7cqlzTb+PaLzbxRO2Uo1qtoAuAdusYoBcLc4q18
 bylaUIQqp7AFa5UX8yMhPso3MNdQpMY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140044
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

On 13/8/26 17:48, Bin Meng wrote:
> 
> Most ARM board files declare their struct arm_boot_info as a static
> object at file scope (or, occasionally, as a function-local static
> inside the machine init function). arm_load_kernel() stashes a pointer
> to that struct in every CPU and dereferences it from do_cpu_reset() on
> each reset, so the boot info conceptually belongs to the machine for the
> lifetime of the VM, not to a static object whose ownership is left
> implicit.
> 
> This is a longstanding leftover pattern: modern machines such as virt,
> raspi and xlnx-zcu102 already keep the boot info in their MachineState
> subclass. This series converts the remaining machines that still use
> a static object, moving the struct into their machine state so that its
> lifetime and ownership match how arm_load_kernel() actually uses it.

I wanted that cleanup since a long time, excellent, thanks Bin!


