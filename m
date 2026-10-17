Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78A9CCF2CA
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI8Mk-0001C9-4W; Sat, 17 Oct 2026 13:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8Mj-0001Bv-4B
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:38:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8Mh-0004aO-Cy
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:38:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69HG9sqM1332658
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AsKGxnEn10AGvlbnZCrBBWjw4gZy/ctwIOPePx/svKY=; b=Ftx7dByo9klftRrh
 OQ3+HmIZtX5NY57JG+vX5TPk2CSj3BFb7SOLTMC38FIUMzAn1qCgwQVHJXjtw8OC
 M/smvUxMgr2taaMVFfxI0dq7x9Hm10wkItMP2JerO2SnrwN1488m6tTA5e31aIBW
 WnPlWVGdEfLMnJrHqvpiQTogSxt9L0hediS4Oek8lxDoU7eMDZlIOIUDELhRztUa
 To5hcbn4tBhCwBFaui5ZQLB164gtK7hbvHlBcF/9jsNsriJMEpBudvp0NTlRBqWD
 sBeJk73ol9utApnXrMp0+OctqgVRQdgOnfLnFqahPnDFhxJsJHfx25XcFxJEkKoh
 /s95uA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbxcnss4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:38:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso1425832eec.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792258717; x=1792863517; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AsKGxnEn10AGvlbnZCrBBWjw4gZy/ctwIOPePx/svKY=;
 b=ccZsv7yWUBT+ALgri5CGaNOT9YwzX6phrdKgAMiDKvi6X/uZgjfowKFth2647312iU
 DDEj4VNBlZ3ZmZMPTkXlvirLEBoMuh3s1btBLZfzoYpMGc41stBhvA+M+NUhkLZzvUov
 66e0Wxfz5nIVauccj5G8n7hCeUyt+T/0N1vc91PGyiDqC7322hzAo8MMZEA2DSugxj3Z
 axtp7ceEA6ca0qeuM3165sLoY5+NBFeK9x3EpdSAxVow99vA3wxCrEjUJwvk80WGoxIR
 BGfe6XtBsaQFvTAGT6kn3mrxMMWhtOnMD9DJ/CI1CBqDpH2+EH0LVHdebNndNvs0OMJz
 CC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792258717; x=1792863517;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AsKGxnEn10AGvlbnZCrBBWjw4gZy/ctwIOPePx/svKY=;
 b=jS27lvOIfExXdQSrlgKAuFjtyQAGH/ljwUl+ufZuX7Y3GhuFWAj1/B1HNE0ivhL3vz
 zcb/p0S7PSJIjTMrdNQ1OWQXU/DYKVZtjRbeIWLb+Mvm+udXyNGjCkKRe/4yg0BQR9d8
 tIu/dip1YotdotyctqvEeICUkBx/UWeuEzvxIy+ASpchjPrkAH1fWbl+h8YJp67pVImY
 3sYHOan21mdZMSwXoI2XM8kurl8umF0+YK9N7fwl3cB/gJgA2AWPxdzw6vVMk4qH7uf3
 vIZPtG5/tnTj8myOlEej1CYAEtGBqRYp87O3sb5VMhYzechqz2w1t7XJvQ9uURiMi+B/
 +AXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4NAzg/fV8sSd+pG+EZOe0I2ueIMKQ3/lc6cVGrDLwEPMG7Oy8GHEEsA/Kpnmzf3nZJgBk7yS3pHG9@nongnu.org
X-Gm-Message-State: AFq9FYIqP+CBPEfwIwM5ZqsP5VcfU58Pbm9L6/wCJMYd1DjwBPX1Wq+r
 5E1FoIHY+Jq5Hdd/wCWc1MgqbEfzej2SzjKkghStwiKl8Z/Lyx4cv1O8uu+8Jh/3fqC2cDKii0G
 fMhsRHXjGdDWI7Dfq0jtX2kDvsHmrCF7nFRnstkB5vcCcJzZZL1a+qK6m/MRTRyz5lw==
X-Gm-Gg: AYBFou1hDujB93bLUF+jdEPQMq1AAaoIApWvofQfjuFPoGgefweFWh9CPav8CFkm6hV
 lWDhHC5Havzu9bXqRZ/GM+jp8W+d45K9e81qhnJr8+EDp0t3GMd9aPT90ly9sNvu5yiBDmg79VJ
 5F1ZE6EMXlUJDYE0SZ6mCPAx0/AKbOQLF81fZBDiStWeTZABVCKH3Y5Ya1J1MwYbKOey74IiYbI
 EQpinymtLtCTJ1l8GjVL9KKk+LZ2bthoQXkDGkeRkg2LSB7pUjzM61dj9xpnqNE0KzC04W6b0PT
 eR9CGNxEz1VI06WpK+Nq5rmes+wGdswR7snLKaWlMZQ/tezFowWcU4RxraRpBt1wA40WTyJQRkn
 f3JZbA0RNLY9Dfr/+CSQujCkGRrboYFefZASkiUuIVvlh1FeuwDygHuxpxksMs1gxA0FcNQ==
X-Received: by 2002:a05:701b:4212:20b0:143:3c9f:10a6 with SMTP id
 a92af1059eb24-1850c40d561mr5096979c88.4.1792258716991; 
 Sat, 17 Oct 2026 10:38:36 -0700 (PDT)
X-Received: by 2002:a05:701b:4212:20b0:143:3c9f:10a6 with SMTP id
 a92af1059eb24-1850c40d561mr5096907c88.4.1792258715497; 
 Sat, 17 Oct 2026 10:38:35 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm15680524c88.15.2026.10.17.10.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2026 10:38:34 -0700 (PDT)
Message-ID: <c8c6c4e3-82cc-46ea-acc9-7f62ec3a4cb9@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 10:38:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: match custom target name to executable name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261017074226.1347492-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261017074226.1347492-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BNUmP1QG c=1 sm=1 tr=0 ts=6ad3b29d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LqGOkDN_i7p1TiLf-sAA:9 a=QEXdDO2ut3YA:10
 a=i4_ie1WIf3YA:10 a=VxAk22fqlfwA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: yPuNW-Osmhk7VfVcGczCdEaNjtOJSqVk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX7MlG7jNO4U4b
 aPwc9ORta3XgNBcoRXtZBZX15+17V6TeuxryTHC7/yJq3csHtwu8MYym0xD3jg+R5WBqBEt+F2z
 K7rrVyyjhAJBsfV1ZUDZ09EC5u4hZAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX/85SXnqE6AOH
 kXjXDmfBn4fRSpOubXM9vEHzzG1GyY4X9ycR3u4aAlQZPF5SJlBx9mbsPeR4PlGyJhnJEm5XsyH
 rQyArKrZj5w5uCFlPtCoywCqGywwIIbcsKgjo53Vtduq2LUzo9pNkulhhlHnLHOK5ksDF8GqiMi
 olF8BarUlyZEDSi53rwSaOdInyrazCbGZ2ZC4zbrpBEzAT6f8/yI/jzslKGz6CddNmOIcpXvTu+
 ZiXsaepLeHP2kCIfhgLUH5ktAJL2BZSml5Zg0wYySRZQuojvY4XtHc32acmlHTJbbOumIdUuvRX
 kTb6KbYq5K8NLN+rVlY7cm+MyYp+EXPVeCHvWg2SQWZ4VgrZG9KuRmJGMZQUzLU8juNEVsoW5KW
 zAFohA4S9sD2B2nGpYEQyWcAStX7clQfrdpU6RhFi8l54zx+seyKDHsjBNma16QNnyoWkuSbDiR
 Iu8yFKXiBr5hPgoDc6Q==
X-Proofpoint-ORIG-GUID: yPuNW-Osmhk7VfVcGczCdEaNjtOJSqVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170070
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

On 10/17/2026 12:42 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tcg/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

