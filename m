Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A24C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2Ro-00011T-WC; Tue, 07 Jul 2026 05:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh2Rn-000110-2K
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:50:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh2Rk-0003EW-Hf
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:50:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678E4Si3004578
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nZj9VXEnWTmffYur+Fuun9fDxEdbNBQtuFbuYXkO0is=; b=SAUdudbphcJTOcle
 VH1kI0EXYwRZ1N/eORteUnpOv8ERerKTqr7b87fnQOT4Epkl73zjPyt7t3Pugbpq
 eCKSVZakhVOCBRzGsqH+4MlWVQLf0zIyDhnrks/vUMCnwa3rtN19BDh1S+5wL10h
 2B9q3+2pzcemgIhG7zILksb8chP3YbgS5qgh3gPvLdou9NfwncyDJru0Psa+3FJ+
 xdKxy7UtSHpxRuKc76Kay0ogcPbA7TZhul0NQDPL84GRSblv+hfz6TmV7nVe60Va
 OVcE3EUv88yyK1hAE1RG02oHROToUidE62W43Zi60jzsnBkgCJSY9BzKPP5CQ36u
 CKtj6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su71asb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:50:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1ada6c43so57529431cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783417829; x=1784022629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nZj9VXEnWTmffYur+Fuun9fDxEdbNBQtuFbuYXkO0is=;
 b=LfENPea/2hqdv5f5QvH5lTdXTLTFzKwX3tHOXJTOrjV6RuJsFBfz8Tyzqkeuw3vBRm
 LpC+0HpRT98Lvn09YsPzsBh7MZ/aLmD7gcBpC8JNEDKlH2f/gmIAgMHve5cndJBmgRpz
 AnI50HU4pGC1vLbpwKskT96I/kDl9oSW4eUyqT2iR1dN+naiEJbJ1uga1q3fQv8DLeKr
 9D+tSSSlJWxRDmRIi7pni3tpTLZbl+7YsoPyZhx35XMX7Y8CjOBiPuusaIXEVEISAfHD
 2pOdx+SRKMU3AQ6EL3XujzL97jM8f9cqLHV1Dsyrv4KrSB+91kFvBuhRPZAW50F+WQDU
 RbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783417829; x=1784022629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZj9VXEnWTmffYur+Fuun9fDxEdbNBQtuFbuYXkO0is=;
 b=r8dKMsAsyaDhio/4e4k6EivazlUu7dK4RSioZx09zNhXcK52hSLDONBuhvAw7zsf1v
 3thJUzqb435+wpUdQCkJMzhX4qkZKnTFQRuaTaHBlii3tsvC1aPBfDPfjlBEUUhrvkxl
 D1iEsqqT0dtrs+Mwc/iLFNtOENR7TIbQnjMJUI1XCoM6btxIqwKWsnPE9s2/blLF29nS
 Nmsh9BTZsBGORBUl3LGmKrolCoWUE/1KuTQb3Ugxb2zmOsTclkJJQC+yDU8hxWRFUQmy
 +U/tu6R9yl6mZHgYmNHG18197hkw8a4Qm8Z2mPtgFvBTcwSnZ6BEak28YJMi6ymdzT7E
 VFWQ==
X-Gm-Message-State: AOJu0Yy5jY1Hsfbl7TkEhpfxpjRwTDtaro7fI7MlyNtGiF0L4F3/iC8I
 CAzGrk7kW8jKcGF5IB+Otnj0bHmDuwSBkGZuLLVyAkdq3wfQZP6DzdelBOrhfE9d40br1tKmPVK
 23sZBsuxcAgQdZuo4xf4+F/Z6ZavCfWIVftsfKyGwkTOhjjIrkhOnCqGf4BMNgnFIlw==
X-Gm-Gg: AfdE7cmf1UI4aQnUQedCll79XLyYxJAgyeuz0Rsb2IjJhI96O9C0SOwuu4ZlYuOzU9e
 W/zvzT3M1nsjGPkMBs3ECG/dPqFif3fJcRuOSR2cnN2AbYD7YekCWWcmxDQdEeHuDE1a8Fiqri0
 I21CfQQN7wZXYATHQDvWcRL4FZ3PHMUbTtYolxUlNORfBisf3Nda2NYblWk0Zf1Ox7AsFcBeAbg
 /gGaSMilE6RpMkgbSZHeRiVG8Nr+xx+uAoE9zpDkZA3ntFLpG/lVoK9kO5Nsmqv7++hrfc3DQNB
 VGu5xKEJXE9RpIPq4zoIns3qvNkhsBT9LqUprZ9QP4rX1eeBkXoGBJdvTgIbHgEX4X3JdoPS9Ju
 6sK43d16RCN6xYNOgjHHKJtFtH9MZ3VgFi5ZxY0GFcuNaY6qvA1PjBDAg7UQN4g==
X-Received: by 2002:a05:622a:cb:b0:51c:7b12:5fcf with SMTP id
 d75a77b69052e-51c7b126511mr17750821cf.75.1783417828737; 
 Tue, 07 Jul 2026 02:50:28 -0700 (PDT)
X-Received: by 2002:a05:622a:cb:b0:51c:7b12:5fcf with SMTP id
 d75a77b69052e-51c7b126511mr17750491cf.75.1783417828126; 
 Tue, 07 Jul 2026 02:50:28 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad844cacsm98510966b.19.2026.07.07.02.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:50:27 -0700 (PDT)
Message-ID: <693c31c8-a3f9-4cd2-8374-e4638ff34d92@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu-options: Enable the -enable-kvm option for loongarch
Content-Language: en-US
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260705-add-loong64-kvm-v1-1-aa8b85ecfa32@gmail.com>
 <2d2e2609-ff6d-448d-9a78-9e9b6b9a9ec2@oss.qualcomm.com>
 <B737D5FB-43B3-478D-BD78-E5A2A8296B6A@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <B737D5FB-43B3-478D-BD78-E5A2A8296B6A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfX5ntbJgSmom7I
 ZYbx4MJ+nPMxt1J8+9tBta/gMyeU3DSXknc6m/a/2yQMnzqBY6aKYblXfsmgjPTrzzYoakj+BAo
 nC6QwGxiB5ZSGQCdhA5G+CBgIrneayNpsKfYHE218/wYejrDC6VPcdX3aQ3CjcEbJ5I1EHWJpG+
 2BOCh5cTz4dtrTnX25z8s6S8zUdf4O+LrPDVUXfaJtawL+LXoBZmgw1YukHQuZs3rCdL8ofxkp/
 vcYvZvCOrtnGFhKUofruYOcRULDi5nQV+al4xDt1HveMVyRv11BZlkyNSo88vRxGnYlMLWxdHcs
 6V7uS6UElAf2RBYc2u0fLx5XKEnifPvCxB8aF5EuqbyLftfNVVsB6c9lMRHVqNNf7APNhEpRddl
 2DYQRfr0GZLcdeHGYync6t7CD67HtDL0rH8+LkYkg/UBV0EV/tNxZaY6UREQGVW4qnaaV+0ID5+
 Q0HAoYoIxggXx71G2Fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfXxtvNU8EcrLWG
 fTRYhvGNzL6XTUxcQlvinGeZYMvagTwDw1qSaKmyO8LYEI0/yYnDryvr/GOJdvsCgQf0Gi361Ew
 nfcTKjpe6K4v7zhgD1ZZNT4aebsEW88=
X-Proofpoint-GUID: obXlwHTcXDSrTX-dlOEoQ44tPo0_j7y_
X-Proofpoint-ORIG-GUID: obXlwHTcXDSrTX-dlOEoQ44tPo0_j7y_
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4ccbe5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=RMmbFdJtd2CDAKUiIfgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070094
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

On 7/7/26 11:01, Miao Wang wrote:
> Hi,
> 
>> 2026年7月7日 16:57，Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> 写道：
>>
>> Hi,
>>
>> On 4/7/26 21:50, Miao Wang via B4 Relay wrote:
>>> From: Miao Wang <shankerwangmiao@gmail.com>
>>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>>> ---
>>>   qemu-options.hx | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index e44b47de68137120da9979fb081d0c108f13179c..c7dbbd01e73367380fcf653fa8d0d18795dde9a7 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -5164,7 +5164,7 @@ ERST
>>>   DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
>>>       "-enable-kvm     enable KVM full virtualization support\n",
>>>       QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC |
>>> -    QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
>>> +    QEMU_ARCH_RISCV | QEMU_ARCH_S390X | QEMU_ARCH_LOONGARCH)
>>>   SRST
>>>   ``-enable-kvm``
>>>       Enable KVM full virtualization support. This option is only
>>
>> Isn't the legacy option for "-accel kvm"? (Apparently since commit
>> 303d4e865b7 which is from September 2010). Maybe we should get rid
>> of the '-enable-kvm' use in examples / scripts...
> 
> 
> Yes, but I noticed that there are still users of it. I believe that
> either we can fully remove this option or we should enable this
> option for every architecture for which kvm is actually supported.

Why do you want to add this legacy option to an architecture which is
newer than the new CLI option and don't even need it listed at all in
the help message?


